module lang::mq::Desugar

import lang::mq::AST;

private Stat prefixPath(Stat stat, Path prefix) = 
   visit (stat) { case Path path => prefix + path };

public Stat desugar(Stat stat) {
  Stat old;
  do { // innermost is broken
    old = stat;
    stat = visit(stat) {
      case ifThenElse(c, tb, eb) => block([ifThen(c, tb), ifThen(not(c), eb)])
      case ifThen(c1, block(ss)) => block([ ifThen(c1, s) | s <- ss ])
      case ifThen(c1, ifThen(c2, b)) => ifThen(and(c1, c2), b)    
      case block([s1*, block(ss), s2*]) => block(s1 + ss + s2)
      case block([s1*, assign(x, t), s2*]) => block([s1, ifThen(\bool(true), assign(x, t)), s2])
      case block([s1*, equate(x, e), s2*]) => block([s1, ifThen(\bool(true), equate(x, e)), s2])
      case upto(x, b, s) => ( prefixPath(s,  x + [subscript(b - 1)]) |  
                                    block([prefixPath(s, x + [subscript(b - n - 1)]),
                                        ifThen(path(x + [subscript(b - n - 1)]), it)]) | n <- [0..b-1] )
      case times(x, b, s) => block([ prefixPath(s, x + [subscript(n)]) | n <- [0..b-1]])
      case optional(p, e, s) => block([prefixPath(s, p), ifThen(not(p), equate(p, e))])
      case and(x, \bool(true)) => x
      case and(\bool(true), x) => x
    }
  }
  while (stat != old);
  return stat;
}




