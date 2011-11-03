module lang::TaxSpec

start syntax Spec = Group*;

syntax Group = @Foldable "group" String "{" Datum* "}";

syntax Datum = @Foldable "datum" Id ":" Type "{" Name Description Condition* Explanation "}";

syntax Condition = "cond" Response String;

syntax Response 
  = "[" Int "]"
  | "[" Int "/" Int "]";

syntax Name = "name" String;

syntax Description = "description" String;

syntax Explanation = "explanation" String;

syntax Type 
  ="Datum"
  | "Datumtijd"
  | "Bedrag" "(" Int "," Int ")"
  | "Bedrag" "(" Int ")" 
  | "N" "(" Int ")"
  | "X" "(" Int ")";
  
lexical Int = [0-9]+ !>> [0-9];
lexical String = [\"] StrChar* [\"];
lexical StrChar = ![\"] | [\\][\"];

lexical Id 
  = ([a-z A-Z 0-9 _] !<< [a-z A-Z][a-z A-Z 0-9 _]* !>> [a-z A-Z 0-9 _])  
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
  