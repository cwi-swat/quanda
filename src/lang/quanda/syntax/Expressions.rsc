module lang::quanda::syntax::Expressions

extend lang::quanda::syntax::Layout;
extend lang::quanda::syntax::Lexical;

syntax Expression
  = @category="MetaVariable" Id
  | @category="Constant" Bool
  | @category="Constant" Int
  | @category="Constant" String
  | "any" "(" {Expression ","}+ ")"
  | "all" "(" {Expression ","}+ ")"
  | "sum" "(" Expression "|" {Expression ","}+ ")"
  | "avg" "(" Expression "|" {Expression ","}+ ")"
  | bracket "(" Expression ")"
  | Expression "." Id
  > "+" Expression
  | "-" Expression
  | "!" Expression
  > right Expression "**" Expression
  > non-assoc (
      left Expression "*" Expression
    | Expression "/" Expression
    | Expression "%" Expression
  )
  > left (
      Expression "+" Expression
    | Expression "-" Expression
  )
  > non-assoc (
      Expression "\<" Expression
    | Expression "\>" Expression
    | Expression "\<=" Expression
    | Expression "\>=" Expression
    | Expression "in" Expression
    | Expression "notin" Expression
  )
  > left (
      Expression "==" Expression |
    | Expression "!=" Expression
    ) 
  > left Expression "&&" Expression
  > left Expression "||" Expression
  ;
  
keyword Keyword
  = "any"
  | "all"
  | "sum"
  | "avg"
  | "in"
  | "notin"
  ;


  

  