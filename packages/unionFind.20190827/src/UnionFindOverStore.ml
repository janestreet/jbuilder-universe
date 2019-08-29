(***************************************************************************)
(*                                                                         *)
(*                                 UnionFind                               *)
(*                                                                         *)
(*                       François Pottier, Inria Paris                     *)
(*                                                                         *)
(*  Copyright Inria. All rights reserved. This file is distributed under   *)
(*  the terms of the GNU Library General Public License version 2, with a  *)
(*  special exception on linking, as described in the file LICENSE.        *)
(***************************************************************************)

(* This module offers a union-find data structure based on disjoint set
   forests, with path compression and linking by rank. *)

(* The rank of a vertex is defined as the maximum length, in edges, of an
   uncompressed path that leads to this vertex. In other words, the rank of
   [x] is the height of the tree rooted at [x] that would exist if we did not
   perform path compression. *)

open Store

module Make (S : STORE) = struct

(* -------------------------------------------------------------------------- *)

(* The content of a vertex is either a pointer to a parent vertex (if the
   vertex has a parent) or a pair of a rank and a user value (if the vertex
   has no parent, and is thus the representative vertex for this equivalence
   class). *)

type 'a content =
| Link of 'a rref
| Root of int * 'a

(* The type ['a rref] represents a vertex in the union-find data structure.
   It is a mutable reference, as defined by the module [S]. *)

and 'a rref =
  'a content S.rref

(* -------------------------------------------------------------------------- *)

(* The type of stores, and the function for creating a new store, are those
   of the underlying implementation [S]. *)

type 'a store =
  'a content S.store

let new_store : unit -> 'a store =
  S.new_store

(* -------------------------------------------------------------------------- *)

(* [make s v] creates a new root of rank zero. *)

let make (s : 'a store) (v : 'a) : 'a store * 'a rref =
  S.make s (Root (0, v))

(* -------------------------------------------------------------------------- *)

(* [find s x] finds the representative vertex of the equivalence class of [x].
   It does by following the path from [x] to the root. Path compression is
   performed (on the way back) by making every vertex along the path a
   direct child of the representative vertex. No rank is altered. *)

(* The function [find] is currently not exposed to the user, because [get]
   should be what the user needs in most situations. *)

let rec find (s : 'a store) (x : 'a rref) : 'a store * 'a rref =
  let s, cx = S.get s x in
  match cx with
  | Root (_, _) ->
      s, x
  | Link y ->
      let s, z = find s y in
      let s, b = S.eq s y z in
      if b then
        s, z
      else
        let s, link_to_z = S.get s y in
        let s = S.set s x link_to_z in
        s, z

(* -------------------------------------------------------------------------- *)

(* [eq s x y] determines whether the vertices [x] and [y] belong in the same
   equivalence class. It does so via two calls to [find] and a physical
   equality test. *)

let eq (s : 'a store) (x : 'a rref) (y : 'a rref) : 'a store * bool =
  let s, x = find s x in
  let s, y = find s y in
  S.eq s x y

(* -------------------------------------------------------------------------- *)

(* [get_ s x] returns the value stored at [x]'s representative vertex. *)

let get_ (s : 'a store) (x : 'a rref) : 'a store * 'a =
  let s, x = find s x in
  let s, cx = S.get s x in
  match cx with
  | Root (_, v) ->
      s, v
  | Link _ ->
      assert false

(* [get s x] returns the value stored at [x]'s representative vertex. *)

(* By not calling [find] immediately, we optimize the common cases where the
   path out of [x] has length 0 or 1, at the expense of the general case.
   Thus, we call [find] only if path compression must be performed. *)

let get (s : 'a store) (x : 'a rref) : 'a store * 'a =
  let s, cx = S.get s x in
  match cx with
  | Root (_, v) ->
      s, v
  | Link y ->
      let s, cy = S.get s y in
      match cy with
      | Root (_, v) ->
          s, v
      | Link _ ->
          get_ s x

(* -------------------------------------------------------------------------- *)

(* [set_ s x] updates the value stored at [x]'s representative vertex. *)

let set_ (s : 'a store) (x : 'a rref) (v : 'a) : 'a store =
  let s, x = find s x in
  let s, cx = S.get s x in
  match cx with
  | Root (r, _) ->
      S.set s x (Root (r, v))
  | Link _ ->
      assert false

(* [set s x] updates the value stored at [x]'s representative vertex. *)

(* By not calling [find] immediately, we optimize the common cases where the
   path out of [x] has length 0 or 1, at the expense of the general case.
   Thus, we call [find] only if path compression must be performed. *)

let set (s : 'a store) (x : 'a rref) (v : 'a) : 'a store =
  let s, cx = S.get s x in
  match cx with
  | Root (r, _) ->
      S.set s x (Root (r, v))
  | Link y ->
      let s, cy = S.get s y in
      match cy with
      | Root (r, _) ->
          S.set s y (Root (r, v))
      | Link _ ->
          set_ s x v

(* -------------------------------------------------------------------------- *)

(* [link f s x y] requires the vertices [x] and [y] to be roots. If they are
   the same vertex, it does nothing. Otherwise, it merges their equivalence
   classes by installing a link from one vertex to the other. *)

(* Linking is by rank: the smaller-ranked vertex is made to point to the
   larger. If the two vertices have the same rank, then an arbitrary choice
   is made, and the rank of the new root is incremented by one. *)

let link (f : 'a -> 'a -> 'a) (s : 'a store) (x : 'a rref) (y : 'a rref) : 'a store =
  let s, b = S.eq s x y in
  if b then
    s
  else
    let s, cx = S.get s x in
    let s, cy = S.get s y in
    match cx, cy with
    | Root (rx, vx), Root (ry, vy) ->
        let v = f vx vy in
        if rx < ry then
          let s = S.set s x (Link y) in
          let s = S.set s y (Root (ry, v)) in
          s
        else
          let s = S.set s y (Link x) in
          let r = if ry < rx then rx else rx + 1 in
          let s = S.set s x (Root (r, v)) in
          s
    | Root _, Link _
    | Link _, Root _
    | Link _, Link _ ->
        assert false

(* -------------------------------------------------------------------------- *)

(* [union f s x y] is identical to [link f s x y], except it does not require
   [x] and [y] to be roots. *)

let union (f : 'a -> 'a -> 'a) (s : 'a store) (x : 'a rref) (y : 'a rref) : 'a store =
  let s, x = find s x in
  let s, y = find s y in
  link f s x y

end
