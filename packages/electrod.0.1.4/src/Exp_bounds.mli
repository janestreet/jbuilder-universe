(*******************************************************************************
 * electrod - a model finder for relational first-order linear temporal logic
 * 
 * Copyright (C) 2016-2018 ONERA
 * Authors: Julien Brunel (ONERA), David Chemouil (ONERA)
 * 
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 * 
 * SPDX-License-Identifier: MPL-2.0
 * License-Filename: LICENSE.md
 ******************************************************************************)

(** Computation of bounds for Elo expressions. *)

type bounds = {
  must : TupleSet.t;
  sup : TupleSet.t;
  may : TupleSet.t;
}

(** Computes the must/may/sup bounds of an expression [exp], given the [domain]
    and a substitution [subst] (substituting a tuple for a variable) *)
val bounds : 
  (Var.t, Tuple.t) CCList.Assoc.t ->
  Domain.t ->
  (Elo.var, Elo.ident) GenGoal.exp -> bounds
