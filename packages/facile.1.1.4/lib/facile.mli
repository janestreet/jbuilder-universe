(***********************************************************************)
(*                                                                     *)
(*                           FaCiLe                                    *)
(*                 A Functional Constraint Library                     *)
(*                                                                     *)
(*            Nicolas Barnier, Pascal Brisset, LOG, CENA               *)
(*                                                                     *)
(* Copyright 2004 CENA. All rights reserved. This file is distributed  *)
(* under the terms of the GNU Lesser General Public License.           *)
(***********************************************************************)
(* $Id: facile.mli,v 1.96 2004/09/03 13:25:55 barnier Exp $ *)

(* Module [Facile]: end-user interface to the FaCiLe library *)

module Debug :
  sig
    val level : string ref
    val log : out_channel ref
    val call : char -> (out_channel -> unit) -> unit
    val internal_error : string -> 'a
    val fatal_error : string -> 'a
    val print_in_assert : bool -> string -> bool
  end

module Misc :
   sig
     val last_and_length : 'a list -> 'a * int
     val gen_int_fun : unit -> (unit -> int)
     val arg_min_array : ('a -> 'b) -> 'a array -> (int * 'b)
     val arg_max_array : ('a -> 'b) -> 'a array -> (int * 'b)
     val int_overflow : float -> bool
     module Operators :
       sig
	 val (=+) : int ref -> int -> unit
	 val (=+.) : float ref -> float -> unit
	 val min : int -> int -> int
	 val max : int -> int -> int
	 val ( * ) : int -> int -> int
	 val (+) : int -> int -> int
	 val (-) : int -> int -> int
	 val sign : int -> int
	 val ( /+ ) : int -> int -> int
	 val ( /- ) : int -> int -> int
       end
     val iter : ('a -> 'a) -> int -> 'a -> 'a
     val goedel : (int -> 'a -> 'a) -> int -> 'a -> 'a
     val protect : string -> (unit -> 'a) -> 'a
   end

module Domain :
    sig
      type elt = int
      type t
      val empty : t
      val create : elt list -> t
      val unsafe_create : elt list -> t
      val interval : elt -> elt -> t
      val int : t
      val boolean : t
      val is_empty : t -> bool
      val size : t -> elt
      val min : t -> elt
      val max : t -> elt
      val min_max : t -> elt * elt
      val iter : (elt -> unit) -> t -> unit
      val interval_iter : (elt -> elt -> unit) -> t -> unit
      val member : elt -> t -> bool
      val values : t -> elt list
      val fprint_elt : out_channel -> elt -> unit
      val fprint : out_channel -> t -> unit
      val sprint : t -> string
      val included : t -> t -> bool
      val add : elt -> t -> t
      val remove : elt -> t -> t
      val remove_up : elt -> t -> t
      val remove_low : elt -> t -> t
      val remove_low_up : elt -> elt -> t -> t
      val remove_closed_inter : elt -> elt -> t -> t
      val intersection : t -> t -> t
      val union : t -> t -> t
      val difference : t -> t -> t
      val diff : t -> t -> t
      val remove_min : t -> t
      val minus : t -> t
      val plus : t -> elt -> t
      val times : t -> elt -> t
      val smallest_geq : t -> elt -> elt
      val greatest_leq : t -> elt -> elt
      val largest_hole_around : t -> elt -> elt * elt
      val choose : (elt -> elt -> bool) -> t -> elt
      val compare : t -> t -> elt
      val compare_elt : elt -> elt -> elt
      val disjoint : t -> t -> bool
    end

module SetDomain :
    sig
      module S : sig
        type t
        val empty : t
        val is_empty : t -> bool
        val mem : int -> t -> bool
        val add : int -> t -> t
        val singleton : int -> t
        val remove : int -> t -> t
        val union : t -> t -> t
        val inter : t -> t -> t
        val diff : t -> t -> t
        val compare : t -> t -> int
        val equal : t -> t -> bool
        val subset : t -> t -> bool
        val iter : (int -> unit) -> t -> unit
        val cardinal : t -> int
        val elements : t -> int list
        val min_elt : t -> int
        val max_elt : t -> int
        val choose : t -> int
        val remove_up : int -> t -> t
        val remove_low : int -> t -> t
      end
      type elt = S.t
      type t
      val min : t -> elt
      val max : t -> elt
      val min_max : t -> elt * elt
      val mem : elt -> t -> bool
      val interval : elt -> elt -> t
      val fprint_elt : out_channel -> elt -> unit
      val fprint : out_channel -> t -> unit
      val included : t -> t -> bool
      val iter : (elt -> unit) -> t -> unit
      val values : t -> elt list
      val elt_of_list : int list -> elt
    end

module Stak :
    sig
      type level
      val older : level -> level -> bool
      val size : unit -> int
      val depth : unit -> int
      val level : unit -> level
      val levels : unit -> level list
      val nb_choice_points : unit -> int
      exception Level_not_found of level
      val cut : level -> unit
      exception Fail of string
      val fail : string -> 'a
      val trail : (unit -> unit) -> unit
      type 'a ref
      val ref : 'a -> 'a ref
      val set : 'a ref -> 'a -> unit
      val get : 'a ref -> 'a
    end

module Data :
    sig
      module Array :
	  sig
	    val set : 'a array -> int -> 'a -> unit
	  end
      module Hashtbl :
	  sig
	    type ('a, 'b) t
	    val create : int -> ('a, 'b) t
	    val get : ('a, 'b) t -> ('a, 'b) Hashtbl.t
	    val add : ('a, 'b) t -> 'a -> 'b -> unit
	    val find : ('a, 'b) t -> 'a -> 'b
	    val mem : ('a, 'b) t -> 'a -> bool
	    val remove : ('a, 'b) t -> 'a -> unit
	    val replace : ('a, 'b) t -> 'a -> 'b -> unit
	    val iter : ('a -> 'b -> unit) -> ('a, 'b) t -> unit
	    val fold : ('a -> 'b -> 'c -> 'c) -> ('a, 'b) t -> 'c -> 'c
	  end
end

module Cstr :
    sig
      exception DontKnow
      type priority
      val immediate : priority
      val normal : priority
      val later : priority
      type t
      val id : t -> int
      val name : t -> string
      val priority : t -> priority
      val fprint : out_channel -> t -> unit
      val is_solved : t -> bool
      val create :
	  ?name:string ->
	    ?nb_wakings:int ->
	      ?fprint:(out_channel -> unit) ->
  	      	?priority:priority ->
	    	  ?init:(unit -> unit) ->
		    ?check:(unit -> bool) ->
		      ?not:(unit -> t) ->
		      	(int -> bool) ->
		      	  (t -> unit) ->
			    t
      val post : t -> unit
      val init : t -> unit
      val one : t
      val zero : t
      val active_store : unit -> t list
    end

module Var :
    sig
      module type ATTR =
  	sig
	  type t
	  type domain
	  type elt
	  type event
	  val dom : t -> domain
	  val on_refine : event
	  val on_subst : event
	  val on_min : event
	  val on_max : event
	  val fprint : out_channel -> t -> unit
	  val min : t -> elt
	  val max : t -> elt
	  val member : t -> elt -> bool
	  val id : t -> int
	  val constraints_number : t -> int
	  val size : t -> int
  	end
      module Attr :
	  ATTR with type domain = Domain.t and type elt = int
      module SetAttr :
	  ATTR with type domain = SetDomain.t and type elt = SetDomain.S.t

      type ('a, 'b) concrete = Unk of 'a | Val of 'b

      module type BASICFD = sig
  	type t
  	type attr
  	type domain
  	type elt
  	type event
  	val create : ?name:string -> domain -> t
  	val interval : ?name:string -> elt -> elt -> t
  	val array : ?name:string -> int -> elt -> elt -> t array
  	val elt : elt -> t
  	val is_var : t -> bool
  	val is_bound : t -> bool
  	val value : t -> (attr, elt) concrete
  	val min : t -> elt
  	val max : t -> elt
  	val min_max : t -> elt * elt
  	val elt_value : t -> elt
  	val int_value : t -> elt
  	val size : t -> int
  	val member : t -> elt -> bool
  	val id : t -> int
  	val name : t -> string
  	val compare : t -> t -> int
  	val equal : t -> t -> bool
  	val fprint : out_channel -> t -> unit
  	val fprint_array : out_channel -> t array -> unit
  	val unify : t -> elt -> unit
  	val refine : t -> domain -> unit
	val refine_low : t -> elt -> unit
	val refine_up : t -> elt -> unit
	val refine_low_up : t -> elt -> elt -> unit
	val on_refine : event
	val on_subst : event
	val on_min : event
	val on_max : event
  	val delay : event list -> t -> ?waking_id:int -> Cstr.t -> unit
  	val int : elt -> t
  	val subst : t -> elt -> unit
  	val unify_cstr : t -> elt -> Cstr.t
      end

      module type FD = sig
   	include BASICFD
	val remove : t -> elt -> unit
  	val values : t -> elt list
  	val iter : (elt -> unit) -> t -> unit
      end

      module Fd : FD with
      type domain = Domain.t and
      type elt = Domain.elt and
      type attr = Attr.t and
      type event = Attr.event

      module SetFd : BASICFD with
        type domain = SetDomain.t and
        type elt = SetDomain.S.t and
        type attr = SetAttr.t and
        type event = SetAttr.event

      val delay : Attr.event list -> Fd.t -> ?waking_id:int -> Cstr.t -> unit
    end
module Reify :
    sig
      val boolean : ?delay_on_negation:bool -> Cstr.t -> Var.Fd.t
      val cstr : ?delay_on_negation:bool -> Cstr.t -> Var.Fd.t -> Cstr.t
      val (||~~) : Cstr.t -> Cstr.t -> Cstr.t
      val (&&~~) : Cstr.t -> Cstr.t -> Cstr.t
      val (<=>~~) : Cstr.t -> Cstr.t -> Cstr.t
      val xor : Cstr.t -> Cstr.t -> Cstr.t
      val not : Cstr.t -> Cstr.t
      val (=>~~) : Cstr.t -> Cstr.t -> Cstr.t
    end
module Alldiff :
    sig
      type algo =
          Lazy
      	| Bin_matching of Var.Fd.event
      val cstr : ?algo:algo -> Var.Fd.t array -> Cstr.t
    end
module Goals :
    sig
      type t
      val name : t -> string
      val fprint : out_channel -> t -> unit
      val atomic : ?name:string -> (unit -> unit) -> t
      val create : ?name:string -> ('a -> t) -> 'a -> t
      val create_rec : ?name:string -> (t -> t) -> t
      val fail : t
      val success : t
      val ( &&~ ) : t -> t -> t
      val ( ||~ ) : t -> t -> t
      val once : t -> t
      val solve : ?control:(int -> unit) -> t -> bool
      val lds : ?step:int -> t -> t
      val unify : Var.Fd.t -> int -> t
      val indomain : Var.Fd.t -> t
      val instantiate : (Domain.t -> int) -> Var.Fd.t -> t
      val dichotomic : Var.Fd.t -> t
      val forto : int -> int -> (int -> t) -> t
      val fordownto : int -> int -> (int -> t) -> t
      module Array :
	  sig
	    val foralli : ?select:('a array -> int) -> (int -> 'a -> t) -> 'a array -> t
	    val forall : ?select:('a array -> int) -> ('a -> t) -> 'a array -> t
	    val existsi : ?select:('a array -> int) -> (int -> 'a -> t) -> 'a array -> t
	    val exists : ?select:('a array -> int) -> ('a -> t) -> 'a array -> t
            val choose_index :
            	(Var.Attr.t -> Var.Attr.t -> bool) -> Var.Fd.t array -> int
            val not_instantiated_fd : Var.Fd.t array -> int
	    val labeling : Var.Fd.t array -> t
	  end
      module GlArray : (* Deprecated *)
	  sig
            val iter_h : ('a array -> int) -> ('a -> t) -> 'a array -> t
            val iter_hi : ('a array -> int) -> (int -> 'a -> t) -> 'a array -> t
            val iter : ('a -> t) -> 'a array -> t
            val iteri : (int -> 'a -> t) -> 'a array -> t
            val iter2 : ('a -> 'b -> t) -> 'a array -> 'b array -> t
            val labeling : Var.Fd.t array -> t
            val choose_index :
            	(Var.Attr.t -> Var.Attr.t -> bool) -> Var.Fd.t array -> int
            val not_instantiated_fd : Var.Fd.t array -> int
	  end
      module List :
	  sig
            val forall : ?select:('a list -> 'a * 'a list) -> ('a -> t) -> 'a list -> t
            val exists : ?select:('a list -> 'a * 'a list) -> ('a -> t) -> 'a list -> t
            val member : Var.Fd.t -> int list -> t
	    val labeling : Var.Fd.t list -> t
	  end 
      module GlList : (* deprecated *)
	  sig
            val iter : ('a -> t) -> 'a list -> t
            val labeling : Var.Fd.t list -> t
            val member : Var.Fd.t -> int list -> t
            val iter_h : ('a list -> 'a * 'a list) -> ('a -> t) -> 'a list -> t
	  end
      type bb_mode = Restart | Continue
      val minimize : ?step:int -> ?mode:bb_mode -> t -> Var.Fd.t -> (int -> unit) -> t
      val sigma : ?domain:Domain.t -> (Var.Fd.t -> t) -> t
      module Conjunto : sig
      	val indomain : Var.SetFd.t -> t
      end

    end
module Sorting :
    sig
      val sort : Var.Fd.t array -> Var.Fd.t array
      val sortp : Var.Fd.t array -> Var.Fd.t array * Var.Fd.t array
      val cstr :
	  Var.Fd.t array ->
	    ?p:Var.Fd.t array option -> Var.Fd.t array -> Cstr.t
    end
module Boolean :
    sig
      val cstr : Var.Fd.t array -> Var.Fd.t -> Cstr.t
      val sum : Var.Fd.t array -> Var.Fd.t
    end
module Expr :
    sig
      type t
      val fprint : out_channel -> t -> unit
      val eval : t -> int
      val min_of_expr : t -> int
      val max_of_expr : t -> int
      val min_max_of_expr : t -> (int * int)
    end
module Arith :
    sig
      type t
      val i2e : int -> t
      val fd2e : Var.Fd.t -> t
      val ( +~ ) : t -> t -> t
      val ( *~ ) : t -> t -> t
      val ( -~ ) : t -> t -> t
      val ( /~ ) : t -> t -> t
      val ( **~ ) : t -> int -> t
      val ( %~ ) : t -> t -> t
      val abs : t -> t
      val sum : t array -> t
      val sum_fd : Var.Fd.t array -> t
      val scalprod : int array -> t array -> t
      val scalprod_fd : int array -> Var.Fd.t array -> t
      val prod : t array -> t
      val prod_fd : Var.Fd.t array -> t
      val fprint : out_channel -> t -> unit
      val eval : t -> int
      val min_of_expr : t -> int
      val max_of_expr : t -> int
      val min_max_of_expr : t -> (int * int)
      val ( <=~ ) : t -> t -> Cstr.t
      val ( <~ ) : t -> t -> Cstr.t
      val ( >~ ) : t -> t -> Cstr.t
      val ( =~ ) : t -> t -> Cstr.t
      val ( <>~ ) : t -> t -> Cstr.t
      val ( >=~ ) : t -> t -> Cstr.t
      val e2fd : t -> Var.Fd.t
      val ( <=~~ ) : t -> t -> t
      val ( <~~ ) : t -> t -> t
      val ( >~~ ) : t -> t -> t
      val ( =~~ ) : t -> t -> t
      val ( <>~~ ) : t -> t -> t
      val ( >=~~ ) : t -> t -> t
      val shift : Var.Fd.t -> int -> Var.Fd.t
      val get_boolsum_threshold : unit -> int
      val set_boolsum_threshold : int -> unit
    end
module Invariant :
    sig
      type ('a, 'b) t
      type setable
      type unsetable
      type 'a setable_t = ('a, setable) t
      type 'a unsetable_t = ('a, unsetable) t
      val create : ?name:string -> 'a -> 'a setable_t
      val constant : ?name:string -> 'a -> 'a unsetable_t
      val set : 'a setable_t -> 'a -> unit
      val get : ('a, 'b) t -> 'a
      val id : ('a, 'b) t -> int
      val name : ('a, 'b) t -> string
      val fprint : out_channel -> ?printer:(out_channel -> 'a -> unit) -> ('a, 'b) t -> unit
      val unary : ?name:string -> ('a -> 'b) -> (('a, 'c) t -> 'b unsetable_t)
      val binary : ?name:string -> ('a -> 'b -> 'c) -> (('a, 'd) t -> ('b, 'e) t -> 'c unsetable_t)
      val ternary : ?name:string -> ('a -> 'b -> 'c -> 'd) -> (('a, 'e) t -> ('b, 'f) t -> ('c, 'g) t -> 'd unsetable_t)
      val sum : (int, 'a) t array -> int unsetable_t
      val prod : (int, 'a) t array -> int unsetable_t
      module Array : sig
  	val get : ('a, 'b) t array -> (int, 'c) t -> 'a unsetable_t
      	val argmin : ('a, 'b) t array -> ('a -> 'c) -> int unsetable_t
      	val min : ('a, 'b) t array -> ('a -> 'c) -> 'a unsetable_t
      end
      module type FD = sig
  	type fd
  	type elt
  	val min : fd -> elt unsetable_t
  	val max : fd -> elt unsetable_t
	val size : fd -> int unsetable_t
  	val is_var : fd -> bool unsetable_t
  	val unary : ?name:string -> (fd -> 'a) -> fd -> 'a unsetable_t
      end
      module Fd : FD with
        type fd = Var.Fd.t and type elt = Var.Fd.elt
	    
      module SetFd : FD with
        type fd = Var.SetFd.t and type elt = Var.SetFd.elt
    end
module Interval :
    sig
      val is_member : Var.Fd.t -> int -> int -> Var.Fd.t
      val cstr : Var.Fd.t -> int -> int -> Var.Fd.t -> Cstr.t
    end
module FdArray :
    sig
      val min : Var.Fd.t array -> Var.Fd.t
      val min_cstr : Var.Fd.t array -> Var.Fd.t -> Cstr.t
      val max : Var.Fd.t array -> Var.Fd.t
      val max_cstr : Var.Fd.t array -> Var.Fd.t -> Cstr.t
      val get : Var.Fd.t array -> Var.Fd.t -> Var.Fd.t
      val get_cstr : Var.Fd.t array -> Var.Fd.t -> Var.Fd.t -> Cstr.t
    end
module Gcc :
    sig
      type level = Basic | Medium | High
      val cstr :
	  ?level:level ->
	    Var.Fd.t array ->
	      (Var.Fd.t * int) array -> Cstr.t
    end
module Opti :
    sig
      type mode = Restart | Continue
      val minimize :
	  Goals.t -> Var.Fd.t ->
	    ?control:(int -> unit) ->
	      ?step:int -> 
	    	?mode:mode ->
		  (int -> 'a) ->
	    	    'a option
    end
module Conjunto :
    sig
      val subset : Var.SetFd.t -> Var.SetFd.t -> Cstr.t
      val cardinal : Var.SetFd.t -> Var.Fd.t
      val smallest : Var.SetFd.t -> Var.Fd.t
      val union : Var.SetFd.t -> Var.SetFd.t -> Var.SetFd.t
      val inter : Var.SetFd.t -> Var.SetFd.t -> Var.SetFd.t
      val all_disjoint : Var.SetFd.t array -> Cstr.t
      val disjoint : Var.SetFd.t -> Var.SetFd.t -> Cstr.t
      val inside : int -> Var.SetFd.t -> unit
      val outside : int -> Var.SetFd.t -> unit
      val inf_min : Var.SetFd.t -> Var.SetFd.t -> Cstr.t
      val order : Var.SetFd.t -> Var.SetFd.t -> Cstr.t
      val order_with_card : Var.SetFd.t -> Var.Fd.t -> Var.SetFd.t -> Var.Fd.t -> Cstr.t
      val member : Var.SetFd.t -> SetDomain.elt list -> Cstr.t
      val mem : Var.Fd.t -> Var.SetFd.t -> Cstr.t
      val sum_weight : Var.SetFd.t -> (int * int) list -> Var.Fd.t
      val atmost1 : Var.SetFd.t array -> int -> unit
    end
module Easy :
    sig
      val i2e : int -> Arith.t
      val fd2e : Var.Fd.t -> Arith.t
      val ( +~ ) : Arith.t -> Arith.t -> Arith.t
      val ( *~ ) : Arith.t -> Arith.t -> Arith.t
      val ( -~ ) : Arith.t -> Arith.t -> Arith.t
      val ( /~ ) : Arith.t -> Arith.t -> Arith.t
      val ( **~ ) : Arith.t -> int -> Arith.t
      val ( %~ ) : Arith.t -> Arith.t -> Arith.t
      val ( <=~ ) : Arith.t -> Arith.t -> Cstr.t
      val ( <~ ) : Arith.t -> Arith.t -> Cstr.t
      val ( >~ ) : Arith.t -> Arith.t -> Cstr.t
      val ( =~ ) : Arith.t -> Arith.t -> Cstr.t
      val ( <>~ ) : Arith.t -> Arith.t -> Cstr.t
      val ( >=~ ) : Arith.t -> Arith.t -> Cstr.t
      val ( <=~~ ) : Arith.t -> Arith.t -> Arith.t
      val ( <~~ ) : Arith.t -> Arith.t -> Arith.t
      val ( >~~ ) : Arith.t -> Arith.t -> Arith.t
      val ( =~~ ) : Arith.t -> Arith.t -> Arith.t
      val ( <>~~ ) : Arith.t -> Arith.t -> Arith.t
      val ( >=~~ ) : Arith.t -> Arith.t -> Arith.t
      val (&&~~) : Cstr.t -> Cstr.t -> Cstr.t
      val (||~~) : Cstr.t -> Cstr.t -> Cstr.t
      val (=>~~) : Cstr.t -> Cstr.t -> Cstr.t
      val (<=>~~) : Cstr.t -> Cstr.t -> Cstr.t
      val ( &&~ ) : Goals.t -> Goals.t -> Goals.t
      val ( ||~ ) : Goals.t -> Goals.t -> Goals.t
      module Fd : Var.FD with
      type t = Var.Fd.t and
      type domain = Domain.t and
      type elt = Domain.elt and
      type attr = Var.Attr.t and
      type event = Var.Attr.event
      type ('a, 'b) concrete' = ('a, 'b) Var.concrete = Unk of 'a | Val of 'b
      type concrete_fd = (Fd.attr, Fd.elt) concrete'
    end


