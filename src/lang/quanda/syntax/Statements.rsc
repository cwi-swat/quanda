module lang::quanda::syntax::Statements

extend lang::quanda::syntax::Expressions;
extend lang::quanda::syntax::Widgets;

syntax Statement
  // Control flow
  = ifThen: "if" "(" Expression ")" Statement () !>> "else"
  | ifThenElse: "if" "(" Expression ")" Statement "else" Statement 
  | forEach: "for" "(" Expression ")" Statement
  | switchCase: "switch" "(" Expression ")" "{" Case* "}"
  | block: "{" Statement* "}"

  // Documentation
  | doc: "doc" String 
  | tip: "tip" String
  
  // Cross referencing
  | ref: "ref" Id String
  | label: "label" Id
  | link: "link" String

  // Layouting
  | section: "section" String Statement
  | group: "group" String Statement
  | par: "par" Statement
  | ul: "list" Statement
  | item: "item" Statement
  | stack: "stack" Statement
  | card: "card" String Statement
  | table: "table" Statement
  | row: "row" Statement
  | col: "col" Statement

  // Content
  | string: String 
  | output: "$" Expression 
  | bind: Id ":" Widget  
  | bindMany: Id ":" "repeat" "(" Expression ")" Statement
  | with: Id ":" "with" "(" Id ")" Statement
  | call: Id "(" {Expression ","}* ")"
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