module lang::quanda::syntax::Expressions

lexical Id 
  = ([a-z A-Z 0-9 _] !<< [a-z A-Z][a-z A-Z 0-9 _]* !>> [a-z A-Z 0-9 _]) \ Keyword 
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
keyword Keyword
  = "any"
  | "all"
  | "sum"
  | "avg"
  | "in"
  | "notin"
  | "true"
  | "false"
  ;

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
  
  
syntax Bool
  = "true" !>> [a-zA-Z0-9_]
  | "false" !>> [a-zA-Z0-9_]
  ;
  
lexical Int
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
  

  