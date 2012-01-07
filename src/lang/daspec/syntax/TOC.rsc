module lang::daspec::syntax::TOC

import lang::daspec::syntax::Lexical;

start syntax TOC = toc: Entry* entries;

// TODO: include header declaring domains.

syntax Entry 
  = datum: Name name "[" Nat key "]"
  | section: "sectie" Title title "{" Entry* entries "}"
  ;
  
  