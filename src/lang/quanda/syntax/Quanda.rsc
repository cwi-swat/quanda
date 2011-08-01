module lang::quanda::syntax::Quanda

extend lang::quanda::syntax::Expressions;

start syntax Form
  = Declaration*
  ;

syntax Declaration
  = "options" Id Signature "{" Option* "}"
  | "def" Id Signature "{" Statement* "}"
  ;
  
keyword Keyword
  = "if"
  | "else"
  | "for"
  | "def"
  | "switch"
  | "section"
  | "group"
  | "par"
  | "table"
  | "row"
  | "col"
  | "check"
  | "range"
  | "rank"
  | "pic"
  | "text"
  | "integer"
  | "boolean"
  | "string"
  | "date"
  | "time"
  | "currency"
  | "list"
  | "item"
  | "ref"
  | "stack"
  | "card"
  ;

syntax Statement
  = "if" "(" Expression ")" Statement () !>> "else"
  | "if" "(" Expression ")" Statement "else" Statement 
  | "for" "(" Expression ")" Statement
  | "switch" "(" Expression ")" "{" Case* "}"
  | "{" Statement* "}"

  | "doc" String 
  | "tip" String
  | "ref" Id String

  | "section" Label Statement
  | "group" Label Statement
  | "par" Statement
  | "list" Statement
  | "item" Statement
  | "stack" Statement
  | "card" Label Statement
  | "table" Statement
  | "row" Statement
  | "col" Statement

  | String 
  | "$" Expression 
  | Id ":" Input  
  | Id ":" "repeat" "(" Expression ")" Statement
  | Id "(" {Expression ","}* ")"
  ; 
  
  
syntax Input
  = "check"
  | "range" "(" Expression ".." Expression ")"
  | "rank" "(" Expression ")"
  | "pic" "(" String ")"
  | "text"
  | "number"
  | Mult "{" Option* "}"
  | Mult Id "(" {Expression ","}* ")"
  ;
  
syntax Mult
  = "one-of"
  | "more-of"
  ;

syntax Case
  = "case" Expression ":" Statement
  ;

syntax Signature
  = "(" {Formal ","}* ")"
  ;
  
syntax Formal 
  = Id ":" Type
  ; 
  
syntax Option
  = Id ":" Label When?
  ;
  
syntax When
  = "when" Expression
  ;
  
syntax Label
  = String
  ;
  
lexical Doc
  = [{] DocChar* [}]
  ;
  
lexical DocChar
  = ![\\}]
  | [\\][}]
  ;
  

syntax Type
  = "integer"
  | "currency"
  | "boolean"
  | "date"
  | "time"
  | "string"
  | Id
  ;