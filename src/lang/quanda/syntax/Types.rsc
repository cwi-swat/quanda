module lang::quanda::syntax::Types

extend lang::quanda::syntax::Lexical;

syntax Type
  = integer: "integer"
  | currency: "currency"
  | boolean: "boolean"
  | date: "date"
  | time: "time"
  | string: "string"
  | user: Id
  ;
  
keyword Keyword
  = "integer"
  | "boolean"
  | "string"
  | "date"
  | "time"
  | "currency"
  ;