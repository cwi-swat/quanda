module lang::daspec::syntax::Lexical

lexical LongName 
  = Word
  | Word [.] !>> [.]
  | Word [\ \t]+ LongName
  ;

lexical Word
  = ![\[\]{}\ \t.]+
  ;

lexical Text = /*@category=String*/ ![}]* >> [}]; 

keyword CommonFormats 
  = "an2" | "an4" | "an6" | "an8" | "an11" | "a1" | "a3"
  | "n1" | "n2" | "n4" | "n6" | "n8" | "n12"
  ;
  
lexical DomainId = Id \ CommonFormats;
  
lexical Nat = [0-9]+ !>> [0-9];
lexical String = [\"] StrChar* [\"];
lexical StrChar = ![\"] | [\\][\"];

keyword Keywords =;

lexical Id 
  = ([a-z A-Z 0-9 _] !<< [a-z A-Z][a-z A-Z 0-9 _]* !>> [a-z A-Z 0-9 _]) \ Keywords
  ;

layout LAYOUTLIST
  = LAYOUT* !>> [\t-\n \r \ ] !>> "//" !>> "/*";

lexical LAYOUT
  = Comment 
  | [\t-\n \r \ ] 
  ;

lexical Comment
    = /*@category="Comment"*/ "/*" (![*] | [*] !>> [/])* "*/" 
    | /*@category="Comment"*/ "//" ![\n]* [\n]
    ;
  