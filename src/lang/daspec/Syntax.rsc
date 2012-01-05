module lang::daspec::Syntax

start syntax Datum = @Foldable "gegeven" Name name "[" Nat key "]" ":" Type type "{" Section* body "}";

lexical Name = /*@category=Variable*/ ![\[]* >> ![\[];

lexical Text = /*@category=String*/ ![}]* !>> ![}]; 

syntax Section 
  = definition: "definitie" "{" Text "}"
  | explanation:  "toelichting" "{" Text "}"
  | algorithm: "bereken" "als" "{" Text "}"
  | source: "bron" "{" Text "}"
  | condition: "conditie" Exp
  | formula: "bereken" "als" Exp
  | usedBy: "gebruikt" "in" {Nat ","}+
  ;

syntax Format
  = fixedAlpha: "a" Nat length
  | fixedAlphaNumeric: "an" Nat length
  | rangeAlphaNumeric: "an" ".." Nat bound
  | fixedNumeric: "n" Nat length
  | numeric: "n" ".." Nat bound
  ;
  

keyword Keywords = 'som' | 'abs' | 'of' | 'en' | 'Als' | 'dan' | 'Gevuld';  

syntax Exp
  = call: "#" Id Exp
  | ref: Ref
  | const: Id // kindaf string symbols
  | sum: 'som'  Exp 
  | abs: 'abs' Exp 
  | bracket "(" Exp ")"
  | left Exp "*" Exp
  >
  left (
       Exp "+" Exp
     | Exp "-" Exp
  )
  > non-assoc (
     eq: Exp "=" Exp
     | gt: Exp "\>" Exp
     | lt: Exp "\<" Exp
     | geq: Exp "\>=" Exp
     | leq: Exp "=\>" Exp
  ) 
  > non-assoc (
     defined: 'Gevuld' Exp
     | isDefined: 'is.gevuld' Exp
     | isEmpty: 'is.leeg' Exp
     | and: 'en' "(" {Exp ";"}+ ")"
     | or: 'of' "(" {Exp ";"}+ ")"
  )
  > ifThen: 'Als' Exp 'dan' Exp
  ;
  
syntax Ref 
  = valuedRef: "[" Nat key "." Value "]" "\<" RefText Sub "\>"
  | ref: "[" Nat key "]" "\<" RefText "\>";

syntax Value
  = nat: Nat
  | id: Id
  ;

lexical RefText = /*@category=String*/ ![.\>]* [.]? >> [.\>]; 

syntax Sub 
  = "." Id "." RefText
  | "." Id
  | ".." RefText
  ;  

  
keyword CommonFormats 
  = "an2" | "an4" | "an6" | "an8" | "an11" 
  | "a1" | "a3"
  | "n1" | "n2" | "n4" | "n6" | "n8" | "n12";
  
  
syntax Type
  = format: Format
  | domain: Id \ CommonFormats
  ;
  
lexical Nat = [0-9]+ !>> [0-9];
lexical String = [\"] StrChar* [\"];
lexical StrChar = ![\"] | [\\][\"];

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
    = @category="Comment" "/*" (![*] | [*] !>> [/])* "*/" 
    | @category="Comment" "//" ![\n]* [\n]
    ;
  