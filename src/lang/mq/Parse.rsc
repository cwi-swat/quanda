module lang::mq::Parse

import ParseTree;
import lang::mq::MQ;

public start[MQ] parse(loc l) = parse(#start[MQ], l);
public start[MQ] parse(str s, loc l) = parse(#start[MQ], s, l);
public start[MQ] parse(str s) = parse(#start[MQ], s);
