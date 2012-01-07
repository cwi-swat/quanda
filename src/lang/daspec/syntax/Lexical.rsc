module lang::daspec::syntax::Lexical

lexical Name = /*@category=Variable*/ ![\[]* >> [\[];

lexical Text = /*@category=String*/ ![}]* >> [}]; 

lexical Title = /*@category=String*/ ![{]* >> [{]; 

lexical ExpName = ![:]+ >> [:];

lexical RefText = /*@category=String*/ ![.\>]+ >> [.]; 
lexical RefTextTail = /*@category=String*/ ![.\>]+ >> [\>]; 

keyword CommonFormats 
  = "an2" | "an4" | "an6" | "an8" | "an11" 
  | "a1" | "a3"
  | "n1" | "n2" | "n4" | "n6" | "n8" | "n12";
  
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
  