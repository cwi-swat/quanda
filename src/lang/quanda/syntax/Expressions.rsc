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
  | bracket "(" Expression ")"
  | "+" Expression
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
  > right Expression "," Expression
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
  

  