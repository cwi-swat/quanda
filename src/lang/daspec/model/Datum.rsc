module lang::daspec::model::Datum

extend lang::daspec::model::Expr;

data Datum = datum(str name, Key key, Type \type, list[Section] body);

data Section
  = definition(str text)
  | explanation(str text)
  | algorithm(str text)
  | page(int no)
  | source(str text)
  | condition(list[str] label, Exp exp)
  | formula(list[str] label, Exp exp)
  | usedBy(list[Key] keys)
  | shorthand(str name)
  | lowerBound(int bound)
  | upperBound(int bound)
  ;

data Type
  = format(Format format)
  | domain(str name) 
  ;

data Format
  = alpha(int length)
  | alphaNumeric(int length)
  | alphaNumericUpTo(int bound)
  | numeric(int length)
  | numericUpTo(int bound)
  | integer(int length)
  | integerUpTo(int bound)
  ;
  
