module lang::daspec::syntax::Datum

import lang::daspec::syntax::Lexical;
import lang::daspec::syntax::Expr;

start syntax Datum
   = /*@Foldable*/ "gegeven" LongName name "[" Nat key "]" ":" Type type
      "{" Section* body "}";

syntax Section 
  = definition: "definitie" "{" Text "}"
  | explanation:  "toelichting" "{" Text "}"
  | algorithm: "bereken" "{" Text "}"
  | page: "pagina" Nat
  | source: "bron" "{" Text "}"
  | condition: "conditie" Label? Exp
  | formula: "bereken" Label? Exp
  | usedBy: "gebruikt" "in" {Nat ","}+
  ;

syntax Label = LongName ":";

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

  