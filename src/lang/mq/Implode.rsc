module lang::mq::Implode

import lang::mq::AST;
import lang::mq::Parse;
import ParseTree;


public MQ implode(Tree t) = implode(#MQ, t);
public MQ parseAndImplode(str s) = implode(parse(s));
public MQ parseAndImplode(str s, loc l) = implode(parse(s, l));
public MQ parseAndImplode(loc l) = implode(parse(l));