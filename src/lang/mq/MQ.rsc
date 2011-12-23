module lang::mq::MQ

start syntax MQ = mq: Stat+;

syntax Stat
  = ifThen: "if" "(" Expression ")" Stat () !>> "else"
  | ifThenElse: "if" "(" Expression ")" Stat "else" Stat 
  | block: "{" Stat* "}"
  | assign: Path ":" Type
  | equate: Path "=" Exp
  | upto: Path ":" "upto" "(" Nat ")" Stat
  | times: Path ":" "times" "(" Nat ")" Stat
  | optional: Path ":" "optional" "(" Exp ")" Stat
  ;

syntax Path = PathElt+;

syntax PathElt
  =  field: "." Id
  | subscript: "[" Nat "]"
  ;  
  
syntax Type
  = string: "str"
  | integer: "int"
  | money: "money"
  ;  
  
  
syntax Expression
  = path: Path
  | @category="Constant" \bool: Bool
  | @category="Constant" nat: Nat
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
      eq: Expression "==" Expression
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

layout LAYOUTLIST
  = LAYOUT* !>> [\t-\n \r \ ] !>> "//" !>> "/*";

lexical LAYOUT
  = Comment 
  | [\t-\n \r \ ] 
  ;
    
lexical Comment
    = @category="Comment" "/*" (![*] | [*] !>> [/])* "*/" 
    | @category="Comment" "//" ![\n]* [\n]
    ;


lexical Id 
  = ([a-z A-Z 0-9 _] !<< [a-z A-Z][a-z A-Z 0-9 _]* !>> [a-z A-Z 0-9 _]) \ Keyword 
  ;


keyword Keyword
  = "true"
  | "false"
  ;

lexical Bool
  = "true" !>> [a-zA-Z0-9_]
  | "false" !>> [a-zA-Z0-9_]
  ;
  
lexical Nat
  = [0]
  | [1-9][0-9]* !>> [0-9]
  ;
  
lexical String
  = [\"] StrChar* [\"]
  ;

lexical StrChar
  = ![\"\\]
  | [\\][\"\\]
  ;
    