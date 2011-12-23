module lang::sordini::Parse

import ParseTree;
import lang::sordini::Syntax;

public start[MQ] parse(loc l) = parse(#start[MQ], l);
public start[MQ] parse(str s, loc l) = parse(#start[MQ], s, l);
public start[MQ] parse(str s) = parse(#start[MQ], s);
