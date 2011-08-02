module lang::quanda::syntax::Types

extend lang::quanda::syntax::Lexical;

syntax Type
  = "integer"
  | "currency"
  | "boolean"
  | "date"
  | "time"
  | "string"
  | Id
  ;
  
keyword Keyword
  = "integer"
  | "boolean"
  | "string"
  | "date"
  | "time"
  | "currency"
  ;