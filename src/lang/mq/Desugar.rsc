module lang::mq::Desugar

import lang::mq::AST;

private Stat prefixPath(Stat stat, Path prefix) = 
   visit (stat) { case path([xs]) => path(prefix + xs) };

public Stat desugar(Stat stat) {
  Stat old;
  do { // innermost is broken
    old = stat;
    stat = visit(stat) {
      case var(x) => path([field(x)]) // normalize vars to paths
      case ifThenElse(c, tb, eb) => block([ifThen(c, tb), ifThen(not(c), eb)])
      case ifThen(c1, block(ss)) => block([ ifThen(c1, s) | s <- ss ])
      case ifThen(c1, ifThen(c2, b)) => ifThen(and(c1, c2), b)    
      case block([s1*, block(ss), s2*]) => block(s1 + ss + s2)
      case block([s1*, assign(x, t), s2*]) => block([s1, ifThen(\bool(true), assign(x, t)), s2])
      case block([s1*, equate(x, e), s2*]) => block([s1, ifThen(\bool(true), equate(x, e)), s2])
      case upto(path(xs), b, s) => ( prefixPath(s,  xs + [subscript(b - 1)]) |  
                                    block([prefixPath(s, xs + [subscript(b - n - 1)]),
                                        ifThen(lvalue(path(xs + [subscript(b - n - 1)])), it)]) | n <- [0..b-1] )
      case times(path(xs), b, s) => block([ prefixPath(s, xs + [subscript(n)]) | n <- [0..b-1]])
      case and(x, \bool(true)) => x
      case and(\bool(true), x) => x
    }
  }
  while (stat != old);
  return stat;
}




