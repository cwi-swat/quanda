module lang::daspec::model::Domains

import lang::daspec::model::Datum;
import lang::daspec::model::Expr;

data Domains = domains(list[Decl] decls);

data Decl = decl(str name, Format format, list[str] mask, list[Range] range);

data Range
  = enum(list[Value] values)
  | range(int fromInt, int toInt)
  | range(real fromReal, real toReal)
  ;  

