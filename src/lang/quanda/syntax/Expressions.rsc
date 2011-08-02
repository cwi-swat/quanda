module lang::quanda::syntax::Expressions

extend lang::quanda::syntax::Layout;
extend lang::quanda::syntax::Lexical;

syntax Expression
  = @category="MetaVariable" var: Id
  | @category="Constant" \bool: Bool
  | @category="Constant" \int: Int
  | @category="Constant" string: String
  | \any: "any" "(" {Expression ","}+ ")"
  | \all: "all" "(" {Expression ","}+ ")"
  | sum: "sum" "(" Expression "|" {Expression ","}+ ")"
  | avg: "avg" "(" Expression "|" {Expression ","}+ ")"
  | bracket "(" Expression ")"
  | field: Expression "." Id
  > pos: "+" Expression
  | neg: "-" Expression
  | not: "!" Expression
  > right pow: Expression "**" Expression
  > non-assoc (
      left mul: Expression "*" Expression
    | div: Expression "/" Expression
    | mod: Expression "%" Expression
  )
  > left (
      add: Expression "+" Expression
    | sub: Expression "-" Expression
  )
  > non-assoc (
      lt: Expression "\<" Expression
    | gt: Expression "\>" Expression
    | leq: Expression "\<=" Expression
    | geq: Expression "\>=" Expression
    | \in: Expression "in" Expression
    | \notin: Expression "notin" Expression
  )
  > left (
      eq: Expression "==" Expression |
    | neq: Expression "!=" Expression
    ) 
  > left and: Expression "&&" Expression
  > left or: Expression "||" Expression
  ;
  
keyword Keyword
  = "any"
  | "all"
  | "sum"
  | "avg"
  | "in"
  | "notin"
  ;


  

  