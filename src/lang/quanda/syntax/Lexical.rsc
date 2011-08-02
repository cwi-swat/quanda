module lang::quanda::syntax::Lexical

lexical Id 
  = ([a-z A-Z 0-9 _] !<< [a-z A-Z][a-z A-Z 0-9 _]* !>> [a-z A-Z 0-9 _]) \ Keyword 
  ;

keyword Keyword
  = "true"
  | "false"
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
  
  