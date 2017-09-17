module type S0 = sig
  type elt
  type t

  val scan: init:elt -> t -> f:(elt -> elt -> elt) -> t
  val scan_i: init:elt -> t -> f:(i:int -> elt -> elt -> elt) -> t
  val scan_acc: acc:'acc -> init:elt -> t -> f:(acc:'acc -> elt -> elt -> 'acc * elt) -> t
end

module type S1 = sig
  type 'a t

  val scan: init:'b -> 'a t -> f:('b -> 'a -> 'b) -> 'b t
  val scan_i: init:'b -> 'a t -> f:(i:int -> 'b -> 'a -> 'b) -> 'b t
  val scan_acc: acc:'acc -> init:'b -> 'a t -> f:(acc:'acc -> 'b -> 'a -> 'acc * 'b) -> 'b t
end
