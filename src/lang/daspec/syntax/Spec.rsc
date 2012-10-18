module lang::daspec::syntax::Spec

extend lang::daspec::syntax::Group;

start syntax Spec 
  = "model" Word type Word version "{" Datum* body "}"
  ; 