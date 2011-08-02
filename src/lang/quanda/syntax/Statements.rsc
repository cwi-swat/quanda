module lang::quanda::syntax::Statements

extend lang::quanda::syntax::Expressions;
extend lang::quanda::syntax::Widgets;

syntax Statement
  // Control flow
  = \if: "if" "(" Expression ")" Statement () !>> "else"
  | \if: "if" "(" Expression ")" Statement "else" Statement 
  | \for: "for" "(" Expression ")" Statement
  | \switch: "switch" "(" Expression ")" "{" Case* "}"
  | block: "{" Statement* "}"

  // Documentation
  | doc: "doc" String 
  | tip: "tip" String
  
  // Cross referencing
  | ref: "ref" "(" Id "," String ")"
  | label: "label" Id
  | link: "link" "(" String "," String ")"

  // Layouting
  | section: "section" String Statement
  | group: "group" String Statement
  | par: "par" Statement
  | \list: "list" Statement
  | item: "item" Statement
  | stack: "stack" Statement
  | card: "card" String Statement
  | table: "table" Statement
  | row: "row" Statement
  | col: "col" Statement

  // Content
  | string: String 
  | output: "$" Expression // todo: widgets for output, e.g. output x + y: numeric 
  | bind: Id ":" Widget  
  | \repeat: Id ":" "repeat" "(" Expression ")" Statement
  | with: Id ":" "with" "(" Id ")" Statement
  | call: Id "(" {Expression ","}* ")"
  
  // (Single assignment)
  | let: Id "=" Expression
  ; 
  
syntax Case
  = "case" Expression ":" Statement
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