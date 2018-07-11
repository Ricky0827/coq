(************************************************************************)
(*         *   The Coq Proof Assistant / The Coq Development Team       *)
(*  v      *   INRIA, CNRS and contributors - Copyright 1999-2018       *)
(* <O___,, *       (see CREDITS file for the list of authors)           *)
(*   \VV/  **************************************************************)
(*    //   *    This file is distributed under the terms of the         *)
(*         *     GNU Lesser General Public License Version 2.1          *)
(*         *     (see LICENSE file for the text of the license)         *)
(************************************************************************)

val dump_global : Libnames.qualid Constrexpr.or_by_notation -> unit

(** Vernacular entries *)
val vernac_require :
  Libnames.qualid option -> bool option -> Libnames.qualid list -> unit

(** The main interpretation function of vernacular expressions *)
val interp :
  ?verbosely:bool ->
  ?proof:Proof_global.closed_proof ->
  st:Vernacstate.t -> Vernacexpr.vernac_control CAst.t -> Vernacstate.t

(** Prepare a "match" template for a given inductive type.
    For each branch of the match, we list the constructor name
    followed by enough pattern variables.
    [Not_found] is raised if the given string isn't the qualid of
    a known inductive type. *)

val make_cases : string -> string list list

(* XXX STATE: this type hints that restoring the state should be the
   caller's responsibility *)
val with_fail : Vernacstate.t -> bool -> (unit -> unit) -> unit

val command_focus : unit Proof.focus_kind

val interp_redexp_hook : (Environ.env -> Evd.evar_map -> Genredexpr.raw_red_expr ->
  Evd.evar_map * Redexpr.red_expr) Hook.t

val universe_polymorphism_option_name : string list

(** Elaborate a [atts] record out of a list of flags.
    Also returns whether polymorphism is explicitly (un)set. *)
val attributes_of_flags : Vernacexpr.vernac_flags -> Vernacinterp.atts -> bool option * Vernacinterp.atts

(** {5 VERNAC EXTEND} *)

type classifier = Genarg.raw_generic_argument list -> Vernacexpr.vernac_classification

(** Wrapper to dynamically extend vernacular commands. *)
val vernac_extend :
  command:string ->
  ?classifier:(string -> Vernacexpr.vernac_classification) ->
  ?entry:Vernacexpr.vernac_expr Pcoq.Entry.t ->
  (bool *
    Vernacinterp.plugin_args Vernacinterp.vernac_command *
    classifier option *
    Vernacexpr.vernac_expr Egramml.grammar_prod_item list) list -> unit

(** {5 STM classifiers} *)

val get_vernac_classifier :
  Vernacexpr.extend_name -> classifier

(** Low-level API, not for casual user. *)
val declare_vernac_classifier :
  string -> classifier array -> unit
