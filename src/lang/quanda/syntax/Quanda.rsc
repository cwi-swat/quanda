module lang::quanda::syntax::Quanda

extend lang::quanda::syntax::Expressions;
extend lang::quanda::syntax::Statements;
extend lang::quanda::syntax::Types;

start syntax Form
  = Declaration*
  ;

syntax Declaration
  = "options" Id Signature "{" Option* "}"
  | "def" Id Signature "{" Statement* "}"
  ;

syntax Signature
  = "(" {Formal ","}* ")"
  ;
  
syntax Formal 
  = Id ":" Type
  ; 


  
