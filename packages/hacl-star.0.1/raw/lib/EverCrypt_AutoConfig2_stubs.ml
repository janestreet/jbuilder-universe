module CI = Cstubs_internals

external _1_EverCrypt_AutoConfig2_has_shaext : unit -> bool
  = "_1_EverCrypt_AutoConfig2_has_shaext" 

external _2_EverCrypt_AutoConfig2_has_aesni : unit -> bool
  = "_2_EverCrypt_AutoConfig2_has_aesni" 

external _3_EverCrypt_AutoConfig2_has_pclmulqdq : unit -> bool
  = "_3_EverCrypt_AutoConfig2_has_pclmulqdq" 

external _4_EverCrypt_AutoConfig2_has_avx2 : unit -> bool
  = "_4_EverCrypt_AutoConfig2_has_avx2" 

external _5_EverCrypt_AutoConfig2_has_avx : unit -> bool
  = "_5_EverCrypt_AutoConfig2_has_avx" 

external _6_EverCrypt_AutoConfig2_has_bmi2 : unit -> bool
  = "_6_EverCrypt_AutoConfig2_has_bmi2" 

external _7_EverCrypt_AutoConfig2_has_adx : unit -> bool
  = "_7_EverCrypt_AutoConfig2_has_adx" 

external _8_EverCrypt_AutoConfig2_has_sse : unit -> bool
  = "_8_EverCrypt_AutoConfig2_has_sse" 

external _9_EverCrypt_AutoConfig2_has_movbe : unit -> bool
  = "_9_EverCrypt_AutoConfig2_has_movbe" 

external _10_EverCrypt_AutoConfig2_has_rdrand : unit -> bool
  = "_10_EverCrypt_AutoConfig2_has_rdrand" 

external _11_EverCrypt_AutoConfig2_wants_vale : unit -> bool
  = "_11_EverCrypt_AutoConfig2_wants_vale" 

external _12_EverCrypt_AutoConfig2_wants_hacl : unit -> bool
  = "_12_EverCrypt_AutoConfig2_wants_hacl" 

external _13_EverCrypt_AutoConfig2_wants_openssl : unit -> bool
  = "_13_EverCrypt_AutoConfig2_wants_openssl" 

external _14_EverCrypt_AutoConfig2_wants_bcrypt : unit -> bool
  = "_14_EverCrypt_AutoConfig2_wants_bcrypt" 

external _15_EverCrypt_AutoConfig2_recall : unit -> unit
  = "_15_EverCrypt_AutoConfig2_recall" 

external _16_EverCrypt_AutoConfig2_init : unit -> unit
  = "_16_EverCrypt_AutoConfig2_init" 

external _17_EverCrypt_AutoConfig2_disable_avx2 : unit -> unit
  = "_17_EverCrypt_AutoConfig2_disable_avx2" 

external _18_EverCrypt_AutoConfig2_disable_avx : unit -> unit
  = "_18_EverCrypt_AutoConfig2_disable_avx" 

external _19_EverCrypt_AutoConfig2_disable_bmi2 : unit -> unit
  = "_19_EverCrypt_AutoConfig2_disable_bmi2" 

external _20_EverCrypt_AutoConfig2_disable_adx : unit -> unit
  = "_20_EverCrypt_AutoConfig2_disable_adx" 

external _21_EverCrypt_AutoConfig2_disable_shaext : unit -> unit
  = "_21_EverCrypt_AutoConfig2_disable_shaext" 

external _22_EverCrypt_AutoConfig2_disable_aesni : unit -> unit
  = "_22_EverCrypt_AutoConfig2_disable_aesni" 

external _23_EverCrypt_AutoConfig2_disable_pclmulqdq : unit -> unit
  = "_23_EverCrypt_AutoConfig2_disable_pclmulqdq" 

external _24_EverCrypt_AutoConfig2_disable_sse : unit -> unit
  = "_24_EverCrypt_AutoConfig2_disable_sse" 

external _25_EverCrypt_AutoConfig2_disable_movbe : unit -> unit
  = "_25_EverCrypt_AutoConfig2_disable_movbe" 

external _26_EverCrypt_AutoConfig2_disable_rdrand : unit -> unit
  = "_26_EverCrypt_AutoConfig2_disable_rdrand" 

external _27_EverCrypt_AutoConfig2_disable_vale : unit -> unit
  = "_27_EverCrypt_AutoConfig2_disable_vale" 

external _28_EverCrypt_AutoConfig2_disable_hacl : unit -> unit
  = "_28_EverCrypt_AutoConfig2_disable_hacl" 

external _29_EverCrypt_AutoConfig2_disable_openssl : unit -> unit
  = "_29_EverCrypt_AutoConfig2_disable_openssl" 

external _30_EverCrypt_AutoConfig2_disable_bcrypt : unit -> unit
  = "_30_EverCrypt_AutoConfig2_disable_bcrypt" 

type 'a result = 'a
type 'a return = 'a
type 'a fn =
 | Returns  : 'a CI.typ   -> 'a return fn
 | Function : 'a CI.typ * 'b fn  -> ('a -> 'b) fn
let map_result f x = f x
let returning t = Returns t
let (@->) f p = Function (f, p)
let foreign : type a b. string -> (a -> b) fn -> (a -> b) =
  fun name t -> match t, name with
| Function (CI.Void, Returns CI.Void), "EverCrypt_AutoConfig2_disable_bcrypt" ->
  _30_EverCrypt_AutoConfig2_disable_bcrypt
| Function (CI.Void, Returns CI.Void),
  "EverCrypt_AutoConfig2_disable_openssl" ->
  _29_EverCrypt_AutoConfig2_disable_openssl
| Function (CI.Void, Returns CI.Void), "EverCrypt_AutoConfig2_disable_hacl" ->
  _28_EverCrypt_AutoConfig2_disable_hacl
| Function (CI.Void, Returns CI.Void), "EverCrypt_AutoConfig2_disable_vale" ->
  _27_EverCrypt_AutoConfig2_disable_vale
| Function (CI.Void, Returns CI.Void), "EverCrypt_AutoConfig2_disable_rdrand" ->
  _26_EverCrypt_AutoConfig2_disable_rdrand
| Function (CI.Void, Returns CI.Void), "EverCrypt_AutoConfig2_disable_movbe" ->
  _25_EverCrypt_AutoConfig2_disable_movbe
| Function (CI.Void, Returns CI.Void), "EverCrypt_AutoConfig2_disable_sse" ->
  _24_EverCrypt_AutoConfig2_disable_sse
| Function (CI.Void, Returns CI.Void),
  "EverCrypt_AutoConfig2_disable_pclmulqdq" ->
  _23_EverCrypt_AutoConfig2_disable_pclmulqdq
| Function (CI.Void, Returns CI.Void), "EverCrypt_AutoConfig2_disable_aesni" ->
  _22_EverCrypt_AutoConfig2_disable_aesni
| Function (CI.Void, Returns CI.Void), "EverCrypt_AutoConfig2_disable_shaext" ->
  _21_EverCrypt_AutoConfig2_disable_shaext
| Function (CI.Void, Returns CI.Void), "EverCrypt_AutoConfig2_disable_adx" ->
  _20_EverCrypt_AutoConfig2_disable_adx
| Function (CI.Void, Returns CI.Void), "EverCrypt_AutoConfig2_disable_bmi2" ->
  _19_EverCrypt_AutoConfig2_disable_bmi2
| Function (CI.Void, Returns CI.Void), "EverCrypt_AutoConfig2_disable_avx" ->
  _18_EverCrypt_AutoConfig2_disable_avx
| Function (CI.Void, Returns CI.Void), "EverCrypt_AutoConfig2_disable_avx2" ->
  _17_EverCrypt_AutoConfig2_disable_avx2
| Function (CI.Void, Returns CI.Void), "EverCrypt_AutoConfig2_init" ->
  _16_EverCrypt_AutoConfig2_init
| Function (CI.Void, Returns CI.Void), "EverCrypt_AutoConfig2_recall" ->
  _15_EverCrypt_AutoConfig2_recall
| Function (CI.Void, Returns (CI.Primitive CI.Bool)),
  "EverCrypt_AutoConfig2_wants_bcrypt" ->
  _14_EverCrypt_AutoConfig2_wants_bcrypt
| Function (CI.Void, Returns (CI.Primitive CI.Bool)),
  "EverCrypt_AutoConfig2_wants_openssl" ->
  _13_EverCrypt_AutoConfig2_wants_openssl
| Function (CI.Void, Returns (CI.Primitive CI.Bool)),
  "EverCrypt_AutoConfig2_wants_hacl" -> _12_EverCrypt_AutoConfig2_wants_hacl
| Function (CI.Void, Returns (CI.Primitive CI.Bool)),
  "EverCrypt_AutoConfig2_wants_vale" -> _11_EverCrypt_AutoConfig2_wants_vale
| Function (CI.Void, Returns (CI.Primitive CI.Bool)),
  "EverCrypt_AutoConfig2_has_rdrand" -> _10_EverCrypt_AutoConfig2_has_rdrand
| Function (CI.Void, Returns (CI.Primitive CI.Bool)),
  "EverCrypt_AutoConfig2_has_movbe" -> _9_EverCrypt_AutoConfig2_has_movbe
| Function (CI.Void, Returns (CI.Primitive CI.Bool)),
  "EverCrypt_AutoConfig2_has_sse" -> _8_EverCrypt_AutoConfig2_has_sse
| Function (CI.Void, Returns (CI.Primitive CI.Bool)),
  "EverCrypt_AutoConfig2_has_adx" -> _7_EverCrypt_AutoConfig2_has_adx
| Function (CI.Void, Returns (CI.Primitive CI.Bool)),
  "EverCrypt_AutoConfig2_has_bmi2" -> _6_EverCrypt_AutoConfig2_has_bmi2
| Function (CI.Void, Returns (CI.Primitive CI.Bool)),
  "EverCrypt_AutoConfig2_has_avx" -> _5_EverCrypt_AutoConfig2_has_avx
| Function (CI.Void, Returns (CI.Primitive CI.Bool)),
  "EverCrypt_AutoConfig2_has_avx2" -> _4_EverCrypt_AutoConfig2_has_avx2
| Function (CI.Void, Returns (CI.Primitive CI.Bool)),
  "EverCrypt_AutoConfig2_has_pclmulqdq" ->
  _3_EverCrypt_AutoConfig2_has_pclmulqdq
| Function (CI.Void, Returns (CI.Primitive CI.Bool)),
  "EverCrypt_AutoConfig2_has_aesni" -> _2_EverCrypt_AutoConfig2_has_aesni
| Function (CI.Void, Returns (CI.Primitive CI.Bool)),
  "EverCrypt_AutoConfig2_has_shaext" -> _1_EverCrypt_AutoConfig2_has_shaext
| _, s ->  Printf.ksprintf failwith "No match for %s" s


let foreign_value : type a. string -> a Ctypes.typ -> a Ctypes.ptr =
  fun name t -> match t, name with
| _, s ->  Printf.ksprintf failwith "No match for %s" s
