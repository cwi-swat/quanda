module lang::daspec::syntax::Datum

extend lang::daspec::syntax::Lexical;
extend lang::daspec::syntax::Expr;

start syntax Datum
   = @Foldable datum: "gegeven" LongName name "[" Key key "]" ":" Type type
      "{" Section* body "}"
   ;

syntax Section 
  = @Foldable definition: "definitie" "{" Text "}"
  | @Foldable explanation:  "toelichting" "{" Text "}"
  | @Foldable algorithm: "bereken" "{" Text "}"
  | page: "pagina" Nat
  | @Foldable source: "bron" "{" Text "}"
  | condition: "conditie" Label? Exp
  | formula: "bereken" Label? Exp
  | usedBy: "gebruikt" "in" {Key ","}+
  ;

syntax Label = LongName ":";

syntax Type
  = @category="Type" format: Format
  | @category="Type" domain: Domain
  ;

// Maybe refactor
syntax Format
  = alpha: "a" Nat length
  | alphaNumeric: "an" Nat length
  | alphaNumericUpTo: "an" ".." Nat bound
  | numeric: "n" Nat length
  | numericUpTo: "n" ".." Nat bound
  | integer: "i" Nat length
  | integercUpTo: "i" ".." Nat bound
  ;
  
  