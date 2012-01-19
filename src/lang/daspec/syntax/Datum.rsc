module lang::daspec::syntax::Datum

extend lang::daspec::syntax::Lexical;
extend lang::daspec::syntax::Expr;

start syntax Datum
   = @Foldable datum: "gegeven" LongName name "[" Key key "]" ":" Type type
      "{" Section* body "}"
   ;

syntax Section 
  = @Foldable definition: "definitie" "{" Text text "}"
  | @Foldable explanation:  "toelichting" "{" Text text "}"
  | @Foldable algorithm: "bereken" "{" Text text "}"
  | page: "pagina" Nat no
  | @Foldable source: "bron" "{" Text text "}"
  | condition: "conditie" Label? label Exp exp
  | formula: "bereken" Label? label Exp exp
  | usedBy: "gebruikt" "in" {Key ","}+ keys
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
  
  