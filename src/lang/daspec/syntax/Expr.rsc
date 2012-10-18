module lang::daspec::syntax::Expr

extend lang::daspec::syntax::Lexical;

keyword Keywords = 'som' | 'abs' | 'of' | 'en' | 'Als' | 'dan' | 'Gevuld' | 'rechts';  

syntax Key = @category="MetaVariable" key: Nat;

syntax Exp
  = call: "#" Id Exp
  | ref: Ref
  | const: Value
  | sum: 'som'  Exp 
  | abs: 'abs' Exp
  | left: 'links' "(" Exp ";" Exp ")" 
  | right: 'rechts' "(" Exp ";" Exp ")" 
  | max: 'max' "(" Exp ";" Exp ")"
  | max: 'min' "(" Exp ";" Exp ")"
  | yearOf: 'jaar-uit' "(" Exp ")"
  | and: 'en' "(" {Exp ";"}+ ")"
  | or: 'of' "(" {Exp ";"}+ ")"
  | bracket "(" Exp ")"
  | defined: 'Gevuld' Exp
  | isDefined: 'is.gevuld' Exp
  | isUndefined: 'is.leeg' Exp
  | pos: "+" Exp 
  > left
    ( mul: Exp "*" Exp
    | div: Exp "/" Exp
    ) 
  >
  left (
       add: Exp "+" Exp
     | sub: Exp "-" Exp
     | cutoff: Exp "-/-" Exp
  )
  > non-assoc (
     eq: Exp [\<] !<< "=" !>> [\>+] Exp
     | gt: Exp "\>" !>> [=] Exp
     | lt: Exp "\<" !>> [=] Exp
     | geq: Exp "\>=" Exp
     | leq: Exp "\<=" Exp
     | neq: Exp "\<\>" Exp
  ) 
  >
  non-assoc(
   | inc: Exp "=+" Exp
   | dec: Exp "=-" Exp
  )
  > ifThen: 'Als' Exp 'dan' Exp
  ;
  
  // todo: =+, = +, =-, = -, <>, =<, -/-
  
syntax Ref 
  = ref: "[" Key key "." Value "]" "\<" LongName Sub "\>"
  | ref: "[" Key key "]" "\<" LongName "\>";

syntax Value
  = nat: Nat
  | sym: Id
  | string: String
  ;
  
lexical String
  = [\'] ![\']* [\']
  ;


syntax Sub 
  = field: "." LongName "." LongName
  | field: "." LongName
  | \value: ".." LongName
  ;  
