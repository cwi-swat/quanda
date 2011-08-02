module lang::quanda::syntax::Statements

extend lang::quanda::syntax::Expressions;
extend lang::quanda::syntax::Widgets;

syntax Statement
  // Control flow
  = "if" "(" Expression ")" Statement () !>> "else"
  | "if" "(" Expression ")" Statement "else" Statement 
  | "for" "(" Expression ")" Statement
  | "switch" "(" Expression ")" "{" Case* "}"
  | "{" Statement* "}"

  // Documentation
  | "doc" String 
  | "tip" String
  
  // Cross referencing
  | "ref" Id String
  | "label" Id
  | "link" String

  // Layouting
  | "section" String Statement
  | "group" String Statement
  | "par" Statement
  | "list" Statement
  | "item" Statement
  | "stack" Statement
  | "card" String Statement
  | "table" Statement
  | "row" Statement
  | "col" Statement

  // Content
  | String 
  | "$" Expression 
  | Id ":" Widget  
  | Id ":" "repeat" "(" Expression ")" Statement
  | Id ":" "with" "(" Id ")" Statement
  | Id "(" {Expression ","}* ")"
  ; 
  
keyword Keyword
  = "if"
  | "else"
  | "for"
  | "def"
  | "switch"
  | "case"
  | "doc"
  | "tip"
  | "ref"
  | "label"
  | "link"
  | "section"
  | "group"
  | "par"
  | "list"
  | "item"
  | "stack"
  | "card"
  | "table"
  | "row"
  | "col"
  | "repeat"
  | "with"
  ;