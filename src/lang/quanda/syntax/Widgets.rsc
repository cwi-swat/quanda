module lang::quanda::syntax::Widgets

extend lang::quanda::syntax::Expressions;

syntax Widget
  // one-of
  = "radio" Enum
  | "dropdown" Enum
  | "spin" Enum
  | "select1" Enum
  // more-of
  | "check" Enum
  | "select" Enum
  // bool
  | "check"
  | "button" "(" String ")"
  // bounded int
  | "slider" "(" Range ")"
  // text
  | "text"  
  | "text" "(" Int ")"  
  | "numeric"
  | "numeric" "(" String ")"
  | "area" "(" Int "," Int ")" 
  ;
  
syntax Range
  = Expression ".." Expression
  | Expression "," Expression ".." Expression
  ;

syntax Enum
  = "{" Option* "}"
  | Id "(" {Expression ","}* ")"
  ;
  
syntax Case
  = "case" Expression ":" Statement
  ;

syntax Option
  = Id ":" String When?
  ;
  
syntax When
  = "when" Expression
  ;
  
keyword Keyword
  = "radio"
  | "dropdown"
  | "spin"
  | "select1"
  | "check"
  | "select"
  | "button"
  | "slider"
  | "text"
  | "numeric"
  | "area"
  ;