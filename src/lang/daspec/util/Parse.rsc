module lang::daspec::util::Parse

import lang::daspec::syntax::Datum;
import lang::daspec::syntax::Expr;
import lang::daspec::syntax::Lexical;
import lang::daspec::syntax::Domains;

import ParseTree;

public start[Datum] parseDatum(loc l) = parse(#start[Datum], l);
public start[Datum] parseDatum(str src) = parse(#start[Datum], src);
public start[Domains] parseDomains(loc l) = parse(#start[Domains], l);
public start[Domains] parseDomains(str src) = parse(#start[Domains], src);


public Exp parseExp(str src) = parse(#Exp, src);
public Exp parseExpWithErrorTree(str src) = parseWithErrorTree(#Exp, src);

public Format parseFormat(str src) = parse(#Format, src);
