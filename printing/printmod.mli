(************************************************************************)
(*         *   The Coq Proof Assistant / The Coq Development Team       *)
(*  v      *         Copyright INRIA, CNRS and contributors             *)
(* <O___,, * (see version control and CREDITS file for authors & dates) *)
(*   \VV/  **************************************************************)
(*    //   *    This file is distributed under the terms of the         *)
(*         *     GNU Lesser General Public License Version 2.1          *)
(*         *     (see LICENSE file for the text of the license)         *)
(************************************************************************)

open Names

(** false iff the module is an element of an open module type *)
val printable_body : DirPath.t -> bool

val pr_mutual_inductive_body : Environ.env ->
  MutInd.t -> Declarations.mutual_inductive_body ->
  UnivNames.univ_name_list option -> Pp.t

type mod_ops =
  { import_module : export:bool -> ModPath.t -> unit
  ; process_module_binding : MBId.t -> Declarations.module_alg_expr -> unit
  }

val print_module : mod_ops:mod_ops -> bool -> ModPath.t -> Pp.t
val print_modtype : mod_ops:mod_ops -> ModPath.t -> Pp.t
