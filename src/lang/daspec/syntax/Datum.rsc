module lang::daspec::syntax::Datum

import lang::daspec::syntax::Lexical;
import lang::daspec::syntax::Expr;

start syntax Datum = /*@Foldable*/ "gegeven" Name name "[" Nat key "]" ":" Type type "{" Section* body "}";

syntax Section 
  = definition: "definitie" "{" Text "}"
  | explanation:  "toelichting" "{" Text "}"
  | algorithm: "bereken" "{" Text "}"
  | page: "pagina" Nat
  | source: "bron" "{" Text "}"
  | condition: "conditie" ExpLabel? Exp
  | formula: "bereken" ExpLabel? Exp
  | usedBy: "gebruikt" "in" {Nat ","}+
  ;

syntax ExpLabel = ExpName ":";


syntax Format
  = fixedAlpha: "a" Nat length
  | fixedAlphaNumeric: "an" Nat length
  | rangeAlphaNumeric: "an" ".." Nat bound
  | fixedNumeric: "n" Nat length
  | numeric: "n" ".." Nat bound
  ;
  

syntax Type
  = format: Format
  | domain: DomainId+ 
  ;

  