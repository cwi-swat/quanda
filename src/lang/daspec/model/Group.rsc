module lang::daspec::model::Group

extend lang::daspec::model::Datum;

data Datum 
  = group(str name, list[Datum] kids)
  ;
