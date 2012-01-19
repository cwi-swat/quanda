module lang::daspec::syntax::Domains

import lang::daspec::syntax::Datum;
import lang::daspec::syntax::Lexical;

start syntax Domains
  = domains: Decl+
  ;

syntax Decl 
  = decl: Domain ":" Format Mask? {Range ","}*
  ;
  

syntax Mask 
  = "[" Placeholder+ "]"
  ;
  
lexical Placeholder
  = [aniEJDM#.+]
  ;

syntax Range
  = enum: {Value "|"}+
  | range: Int ".." Int
  | range: Real ".." Real
  ;
  
lexical Int
  = [\-]? Nat
  ;
  
lexical Real
  = Int "." Nat
  ;