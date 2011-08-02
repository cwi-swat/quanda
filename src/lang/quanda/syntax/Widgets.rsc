module lang::quanda::syntax::Widgets

extend lang::quanda::syntax::Expressions;

syntax Widget
  // one-of
  = radio: "radio" Enum
  | dropdown: "dropdown" Enum
  | spin: "spin" Enum
  | select1: "select1" Enum
  // more-of
  | check: "check" Enum
  | select: "select" Enum
  // bool
  | check1: "check"
  | button: "button" "(" String ")"
  // bounded int
  | slider: "slider" "(" Range ")"
  // text
  | text: "text"  
  | text: "text" "(" Int ")"  
  | numeric: "numeric"
  | numeric: "numeric" "(" String ")"
  | area: "area" "(" Int "," Int ")" 
  
  // date & time
  | date: "date"
  ;
  
syntax Range
  = range: Expression ".." Expression
  | range: Expression "," Expression ".." Expression
  ;

syntax Enum
  = inline: "{" Option* "}"
  | call: Id "(" {Expression ","}* ")"
  ;
  
syntax Option
  = option: Id ":" String 
  | option: Id ":" String "when" Expression
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
  | "date"
  ;