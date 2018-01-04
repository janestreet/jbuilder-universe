open Core
open Async
open Async_smtp

let log =
  Lazy.force Async.Log.Global.log
  |> Smtp_mail_log.adjust_log_levels ~remap_info_to:`Debug

module Config = struct
  type t =
    { dir : string
    ; host : string
    ; port : int
    ; tls : bool
    ; send_n_messages : int
    ; client_allowed_ciphers : [ `Secure | `Openssl_default | `Only of string list ]
    ; server_allowed_ciphers : [ `Secure | `Openssl_default | `Only of string list ]
    ; key_type : [`rsa of int | `ecdsa of string | `dsa of int]
    } [@@deriving fields, sexp]

  let make_tls_certificates t =
    let openssl args = Async_shell.run "openssl" args in
    openssl
      [ "req"
      ; "-new"; "-x509" (* generate the request and sign in one step *)
      ; "-newkey"; "rsa:512" (* generate key *)
      ; "-nodes" (* don't encrypt the key *)
      ; "-batch" (* non interactive *)
      ; "-keyout"; t.dir ^/ "ca.key"
      ; "-out"; t.dir ^/ "ca.crt"
      ; "-days"; "1" (* short shelf life is good for testing *)
      ; "-subj"; "/CN=stress-test-CA/"
      ]
    >>= fun () ->
    begin match t.key_type with
    | `rsa bits ->
      openssl
        [ "genrsa"
        ; "-out"; t.dir ^/ "server.key"
        ; Int.to_string bits
        ]
    | `dsa bits ->
      openssl
        [ "dsaparam"
        ; "-genkey"
        ; "-out"; t.dir ^/ "server.key"
        ; Int.to_string bits
        ]
    | `ecdsa curve ->
      openssl
        [ "ecparam"
        ; "-name"; curve
        ; "-genkey"
        ; "-out"; t.dir ^/ "server.key"
        ]
    end
    >>= fun () ->
    openssl
      [ "req"; "-new"
      ; "-key"; t.dir ^/ "server.key"
      ; "-nodes" (* don't encrypt the key *)
      ; "-batch" (* non interactive *)
      ; "-out"; t.dir ^/ "server.csr"
      ; "-subj"; sprintf "/CN=%s/" t.host
      ]
    >>= fun () ->
    openssl
      [ "x509"; "-req"
      ; "-days"; "1" (* short shelf life is good for testing *)
      ; "-CA"; t.dir ^/ "ca.crt"
      ; "-CAkey"; t.dir ^/ "ca.key"
      ; "-in"; t.dir ^/ "server.csr"
      ; "-out"; t.dir ^/ "server.crt"
      ; "-set_serial"; "1"
      ]
    >>| fun () ->
    let server =
      { Smtp_server.Config.Tls.
        version = None
      ; options = None
      ; name = None
      ; crt_file = t.dir ^/ "server.crt"
      ; key_file = t.dir ^/ "server.key"
      ; ca_file = Some (t.dir ^/ "ca.crt")
      ; ca_path = None
      ; allowed_ciphers = t.server_allowed_ciphers
      }
    in
    let client =
      [ Smtp_client.Config.Domain_suffix.of_string ( t.host),
        { Smtp_client.Config.Tls.
          version = None
        ; options = None
        ; name = None
        ; ca_file = Some (t.dir ^/ "ca.crt")
        ; ca_path = None
        ; mode = `Required
        ; certificate_mode = `Verify
        ; allowed_ciphers = t.client_allowed_ciphers
        }
      ; Smtp_client.Config.Domain_suffix.of_string "",
        { Smtp_client.Config.Tls.
          version = None
        ; options = None
        ; name = None
        ; ca_file = None
        ; ca_path = None
        ; mode = `Required
        ; certificate_mode = `Verify (* Causes the message to fail if we have to wrong host *)
        ; allowed_ciphers = t.client_allowed_ciphers
        }
      ]
    in
    server,client

  let server_and_client_config ~concurrent_receivers t =
    begin if t.tls then begin
      make_tls_certificates t
      >>| fun tls_options -> Some tls_options
    end else begin
        return None
      end
    end
    >>= fun tls_options ->
    let spool_dir = t.dir ^/ "spool-not-used" in
    Deferred.all_ignore
      [ Unix.mkdir ~p:() spool_dir ]
    >>| fun () ->
    let client =
      { Smtp_client.Config.
        greeting = Some "stress-test"
      ; tls = Option.value_map ~f:snd tls_options ~default:[]
      ; send_receive_timeout = `This (Time.Span.of_sec 2.)
      ; final_ok_timeout = `This (Time.Span.of_sec 5.)
      }
    in
    let server =
      { Smtp_server.Config.
        spool_dir
      ; tmp_dir = None
      ; where_to_listen = [`Port t.port]
      ; max_concurrent_send_jobs = 0 (* not used *)
      ; max_concurrent_receive_jobs_per_port = concurrent_receivers
      ; rpc_port = 0 (* not used *)
      ; malformed_emails = `Reject
      ; max_message_size = Byte_units.create `Megabytes 1.
      ; tls_options = Option.map ~f:fst tls_options
      ; client
      }
    in
    server, client
end

let counter = ref 0
let finished = Ivar.create ()

let throttle = ref (Throttle.create ~continue_on_error:true ~max_concurrent_jobs:1)

let send ~config ~client_config envelope =
  incr counter;
  let port = Config.port config in
  let host = Config.host config in
  don't_wait_for (
    Throttle.enqueue !throttle (fun () ->
      Deferred.Or_error.try_with_join (fun () ->
        Smtp_client.Tcp.with_
          ~log:(Lazy.force Log.Global.log)
          (`Inet (Host_and_port.create ~host ~port))
          ~config:client_config
          ~f:(fun client ->
            Smtp_client.send_envelope client ~log envelope
            >>|? Smtp_client.Envelope_status.ok_or_error ~allow_rejected_recipients:false
            >>| Or_error.join
            >>|? ignore
          )))
    >>| Result.iter_error ~f:(Log.Global.error !"buh???: %{Error#hum}"))

let main ?dir ~host ~port ~tls ~send_n_messages ~num_copies
      ~concurrent_senders ~concurrent_receivers ~message_from_stdin
      ?client_allowed_ciphers ?server_allowed_ciphers ~key_type () =
  begin match dir with
  | Some dir -> return dir
  | None -> Unix.mkdtemp "/tmp/stress-test-"
  end
  >>= fun dir ->
  let allowed_ciphers = function
    | None -> `Secure
    | Some allowed_ciphers -> `Only allowed_ciphers
  in
  let config =
    { Config.dir
    ; host
    ; port
    ; tls
    ; send_n_messages
    ; client_allowed_ciphers = allowed_ciphers client_allowed_ciphers
    ; server_allowed_ciphers = allowed_ciphers server_allowed_ciphers
    ; key_type
    }
  in
  begin if message_from_stdin then begin
    let stdin = Lazy.force Reader.stdin in
    Smtp_server.read_bsmtp stdin
    |> Pipe.map ~f:Or_error.ok_exn
    |> Pipe.to_list
  end else begin
      let recipients = [ Email_address.of_string_exn "test@example.com" ] in
      let email =
        Email.Simple.create ~from:(Email_address.local_address ()) ~subject:"Stress test" ~to_:recipients
          (Email.Simple.Content.text "Stress Test")
      in
      let sender = `Null in
      return [Smtp_envelope.create ~sender ~recipients ~email ()]
    end
  end
  >>= fun envelopes ->
  let envelopes =
    List.init num_copies ~f:(fun _ -> envelopes) |> List.concat
  in
  throttle := Throttle.create ~continue_on_error:true ~max_concurrent_jobs:concurrent_senders;
  Config.server_and_client_config ~concurrent_receivers config
  >>= fun (server_config,client_config) ->
  let module Server =
    Smtp_server.Make(struct
      open Smtp_monad.Let_syntax
      include (Smtp_server.Plugin.Simple : Smtp_server.Plugin.S
               with module Session := Smtp_server.Plugin.Simple.Session
                and module Envelope := Smtp_server.Plugin.Simple.Envelope)
      module Session = struct
        include Smtp_server.Plugin.Simple.Session
        let extensions _ =
          [ Smtp_server.Plugin.Extension.Start_tls
              (module struct
                type session = t
                let upgrade_to_tls ~log:_ t = return { t with tls = true }
              end : Smtp_server.Plugin.Start_tls with type session=t)
          ]
      end
      module Envelope = struct
        include Smtp_server.Plugin.Simple.Envelope
        let process ~log:_ _session t email =
          let envelope = smtp_envelope t email in
          begin
            if !counter >= Config.send_n_messages config
            then Ivar.fill_if_empty finished ()
            else send ~config ~client_config envelope
          end;
          return (`Consume (sprintf "stress-test:%d" !counter))
      end
    end)
  in
  Server.start ~log ~config:server_config
  >>| Or_error.ok_exn
  >>= fun server ->
  List.iter envelopes ~f:(send ~config ~client_config);
  Ivar.read finished
  >>= fun () ->
  (* Wait for all pending messages to clear *)
  Throttle.prior_jobs_done !throttle
  >>= fun () ->
  Clock.after (sec 0.1)
  >>= fun () ->
  Server.close server
  >>= function
  | Error e -> Error.raise e
  | Ok () ->
    Deferred.return ()

let cipher_list = Command.Arg_type.create (String.split ~on:':')
let key_type = Command.Arg_type.create (fun s ->
  match String.split ~on:':' s with
  | ["rsa"; bits] -> `rsa (Int.of_string bits)
  | ["dsa"; bits] -> `dsa (Int.of_string bits)
  | ["ecdsa"; curve] -> `ecdsa curve
  | _ -> failwith "not a recognized key type. Supported rsa:BITS, dsa:BITS, ecdsa:CURVE")

let command =
  Command.async_spec
    ~summary:("Stress-test an smtp server by repeatedly sending and receiving a message read from stdin")
    Command.Spec.(
      empty
      ++ step (fun m v -> m ?dir:v)
      +> flag "-dir" (optional string) ~doc:" Working dir"
      ++ step (fun m v -> m ~host:v)
      +> flag "-host" (optional_with_default "localhost" string) ~doc:" Hostname to listen on"
      ++ step (fun m v -> m ~port:v)
      +> flag "-port" (optional_with_default 2525 int) ~doc:" Port to listen on"
      ++ step (fun m v -> m ~tls:v)
      +> flag "-tls" no_arg ~doc:" Run the stress test with TLS enabled"
      ++ step (fun m v -> m ~send_n_messages:v)
      +> flag "-send-n-messages" ~aliases:["-n"] (optional_with_default 1000 int) ~doc:" Number of messages to send"
      ++ step (fun m v -> m ~num_copies:v)
      +> flag "-num-copies" (optional_with_default 1 int) ~doc:" Number of copies of each (the) message to have in circulation"
      ++ step (fun m v -> m ~concurrent_senders:v)
      +> flag "-concurrent-senders" (optional_with_default 1 int) ~doc:" Number of concurrent senders"
      ++ step (fun m v -> m ~concurrent_receivers:v)
      +> flag "-concurrent-receivers" (optional_with_default 1 int) ~doc:" Number of concurrent receivers"
      ++ step (fun m v -> m ~message_from_stdin:v)
      +> flag "-message-from-stdin" no_arg ~doc:" Read the message from stdin, otherwise generate a simple message"
      ++ step (fun m v -> Option.iter ~f:Log.Global.set_level v; m)
      +> flag "-log-level" (optional Log.Level.arg) ~doc:" Log level"
      ++ step (fun m v -> m ?client_allowed_ciphers:v)
      +> flag "-client-allowed-ciphers" (optional cipher_list) ~doc:" Restrict client side SSL ciphers"
      ++ step (fun m v -> m ?server_allowed_ciphers:v)
      +> flag "-server-allowed-ciphers" (optional cipher_list) ~doc:" Restrict server side SSL ciphers"
      ++ step (fun m v -> m ~key_type:v)
      +> flag "-key-type" (optional_with_default (`rsa 2048) key_type) ~doc:" TLS Key type to use/generate"
    )
    main
;;
