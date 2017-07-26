(** Foldable signatures *)

module type Basic = sig
  type _ t

  val foldl : ('a -> 'b -> 'a) -> 'a -> 'b t -> 'a
  val foldr : ('a -> (unit -> 'b) -> 'b) -> (unit -> 'b) -> 'a t -> 'b
end

module type S = sig
  include Basic

  val fold_map : 'a Monoid.t -> ('a -> 'a) -> 'a t -> 'a
  val suml : 'a Monoid.t -> 'a t -> 'a
  val sumr : 'a Monoid.t -> 'a t -> 'a
  val any : ('a -> bool) -> 'a t -> bool
  val all : ('a -> bool) -> 'a t -> bool
end

module Make (F : Basic) : S with type 'a t := 'a F.t

module type M = sig
  type _ t
  type _ m

  val foldr_m : ('a -> 'b -> 'b m) -> 'b -> 'a t -> 'b m
  val foldl_m : ('b -> 'a -> 'b m) -> 'b -> 'a t -> 'b m
end

module type M2 = sig
  type _ t
  type (_, _) m

  val foldr_m : ('a -> 'b -> ('u, 'b) m) -> 'b -> 'a t -> ('u, 'b) m
  val foldl_m : ('b -> 'a -> ('u, 'b) m) -> 'b -> 'a t -> ('u, 'b) m
end

module type M3 = sig
  type _ t
  type (_, _, _) m

  val foldr_m : ('a -> 'b -> ('u, 'v, 'b) m) -> 'b -> 'a t -> ('u, 'v, 'b) m
  val foldl_m : ('b -> 'a -> ('u, 'v, 'b) m) -> 'b -> 'a t -> ('u, 'v, 'b) m
end

