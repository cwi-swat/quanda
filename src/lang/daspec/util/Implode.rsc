module lang::daspec::util::Implode

import lang::daspec::model::Datum;
import lang::daspec::model::Expr;

import ParseTree;

public Exp implodeExp(Tree t) = implode(#Expr, t);
public Format implodeFormat(Tree t) = implode(#Format, t);
