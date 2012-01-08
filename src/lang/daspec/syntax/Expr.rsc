module lang::daspec::syntax::Expr

import lang::daspec::syntax::Lexical;

keyword Keywords = 'som' | 'abs' | 'of' | 'en' | 'Als' | 'dan' | 'Gevuld' | 'rechts';  

syntax Exp
  = call: "#" Id Exp
  | ref: Ref
  | const: Value
  | sum: 'som'  Exp 
  | abs: 'abs' Exp
  | right: 'rechts' "(" Exp ";" Exp ")" 
  | left: 'left' "(" Exp ";" Exp ")" 
  | max: 'max' "(" Exp ";" Exp ")"
  | max: 'min' "(" Exp ";" Exp ")"
  | bracket "(" Exp ")"
  | pos: "+" Exp 
  > left
    ( mul: Exp "*" Exp
    | div: Exp "/" Exp
    ) 
  >
  left (
       add: Exp "+" Exp
     | sub: Exp "-" Exp
  )
  > non-assoc (
     eq: Exp "=" Exp
     | gt: Exp "\>" Exp
     | lt: Exp "\<" Exp
     | geq: Exp "\>=" Exp
     | leq: Exp "\<=" Exp
  ) 
  > non-assoc (
     defined: 'Gevuld' Exp
     | isDefined: 'is.gevuld' Exp
     | isUndefined: 'is.leeg' Exp
     | and: 'en' "(" {Exp ";"}+ ")"
     | or: 'of' "(" {Exp ";"}+ ")"
  )
  > ifThen: 'Als' Exp 'dan' Exp
  ;
  
syntax Ref 
  = ref: "[" Nat key "." Value "]" "\<" RefText Sub "\>"
  | ref: "[" Nat key "]" "\<" RefTextTail "\>";

syntax Value
  = nat: Nat
  | sym: Id
  ;


syntax Sub 
  = field: "." LongName "." LongName
  | field: "." LongName
  | field: "." LongName "."
  | \value: ".." LongName
  ;  
