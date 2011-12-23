module lang::sordini::Implode

import lang::sordini::AST;
import lang::sordini::Parse;
import ParseTree;


public MQ implode(Tree t) = implode(#MQ, t);
public MQ parseAndImplode(str s) = implode(parse(s));
public MQ parseAndImplode(str s, loc l) = implode(parse(s, l));
public MQ parseAndImplode(loc l) = implode(parse(l));