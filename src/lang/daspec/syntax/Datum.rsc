module lang::daspec::syntax::Datum

import lang::daspec::syntax::Lexical;
import lang::daspec::syntax::Expr;

start syntax Datum
   = /*@Foldable*/ "gegeven" LongName name "[" Nat key "]" ":" Type type
      "{" Section* body "}"
   ;

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

syntax Type
  = format: Format
  | domain: DomainId+ 
  ;

syntax Format
  = alpha: "a" Nat length
  | alphaNumeric: "an" Nat length
  | alphaNumericUpTo: "an" ".." Nat bound
  | numeric: "n" Nat length
  | numericUpTo: "n" ".." Nat bound
  ;
  
  