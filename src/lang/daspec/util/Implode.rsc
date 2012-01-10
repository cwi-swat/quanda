module lang::daspec::util::Implode

import lang::daspec::model::Datum;
import lang::daspec::model::Expr;

import ParseTree;

public Datum implodeDatum(Tree t) = implode(#Datum, t);
public Exp implodeExp(Tree t) = implode(#Exp, t);
public Format implodeFormat(Tree t) = implode(#Format, t);
