module lang::daspec::syntax::Group

extend lang::daspec::syntax::Datum;

syntax Datum
  = group: "group" LongName name "{" Datum* kids "}"
  ;  