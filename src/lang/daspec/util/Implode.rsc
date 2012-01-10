module lang::daspec::util::Implode

import lang::daspec::model::Datum;
import lang::daspec::model::Expr;
import lang::daspec::model::Domains;

import ParseTree;

public Datum implodeDatum(Tree t) = implode(#Datum, t);
public Exp implodeExp(Tree t) = implode(#Exp, t);
public Format implodeFormat(Tree t) = implode(#Format, t);
public Domains implodeDomains(Tree t) = implode(#Domains, t);