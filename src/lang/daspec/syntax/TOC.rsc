module lang::daspec::syntax::TOC

import lang::daspec::syntax::Lexical;

start syntax TOC 
  = toc: Entry* entries
  ;

// TODO: include header declaring domains.

syntax Entry 
  = datum: LongName name "[" Nat key "]"
  | /*@Foldable*/ section: "sectie" LongName title "{" Entry* entries "}"
  ;
  
  