module lang::quanda::syntax::Quanda

extend lang::quanda::syntax::Expressions;
extend lang::quanda::syntax::Statements;
extend lang::quanda::syntax::Types;

start syntax Form
  = form: Declaration*
  ;

syntax Declaration
  = options: "options" Id "(" {Formal ","}* ")" "{" Option* "}"
  | def: "def" Id "(" {Formal ","}* ")" "{" Statement* "}"
  ;

syntax Formal 
  = Id ":" Type
  ; 


  
