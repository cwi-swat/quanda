module lang::mq::MQ

start syntax MQ = mq: Stat+;

syntax Stat
  = ifThen: "if" "(" Exp ")" Stat () !>> "else"
  | ifThenElse: "if" "(" Exp ")" Stat "else" Stat 
  | block: "{" Stat* "}"
  | assign: LValue ":" Type
  | equate: LValue "=" Exp
  | upto: LValue ":" "upto" "(" Nat ")" Stat
  | times: LValue ":" "times" "(" Nat ")" Stat
  ;

syntax LValue = var: Id; 

syntax Type
  = string: "str"
  | integer: "int"
  | money: "money"
  ;  
  
  
syntax Exp
  = lvalue: LValue
  | @category="Constant" \bool: Bool
  | @category="Constant" nat: Nat
  | @category="Constant" string: String
  | \any: "any" "(" {Exp ","}+ ")"
  | \all: "all" "(" {Exp ","}+ ")"
  | sum: "sum" "(" Exp "|" {Exp ","}+ ")"
  | avg: "avg" "(" Exp "|" {Exp ","}+ ")"
  | bracket "(" Exp ")"
  > pos: "+" Exp
  | neg: "-" Exp
  | not: "!" Exp
  | field: Exp "." Id
  > right pow: Exp "**" Exp
  > non-assoc (
      left mul: Exp "*" Exp
    | div: Exp "/" Exp
    | mod: Exp "%" Exp
  )
  > left (
      add: Exp "+" Exp
    | sub: Exp "-" Exp
  )
  > non-assoc (
      lt: Exp "\<" Exp
    | gt: Exp "\>" Exp
    | leq: Exp "\<=" Exp
    | geq: Exp "\>=" Exp
    | \in: Exp "in" Exp
    | \notin: Exp "notin" Exp
  )
  > left (
      eq: Exp "==" Exp
    | neq: Exp "!=" Exp
    ) 
  > left and: Exp "&&" Exp
  > left or: Exp "||" Exp
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
    