module lang::mq::AST

import IO;

alias Path = list[PathElt];

data Stat 
  = ifThenElse(Exp cond, Stat then, Stat other)
  | ifThen(Exp cond, Stat then)
  | block(list[Stat] stats) // make this stat: index out of bounds error TupleType.getFieldType.
  | assign(Path path, Type \type)
  | equate(Path path, Exp exp)
  | upto(Path path, int bound, Stat stat)
  | times(Path path, int times, Stat stat)
  | optional(Path path, Exp exp, Stat stat)
  ; 
  
data PathElt
  = field(str name)
  | subscript(int index)
  ;
  

data Type = string();  
  
public Stat normalize(Stat stat) {
  Stat old;
  do {
    old = stat;
    stat = visit(stat) {
      case ifThenElse(c, tb, eb) => block([ifThen(c, tb), ifThen(not(c), eb)])
      case ifThen(c1, block(ss)) => block([ ifThen(c1, s) | s <- ss ])
      case ifThen(c1, ifThen(c2, b)) => ifThen(and(c1, c2), b)    
      case block([s1*, block(ss), s2*]) => block(s1 + ss + s2)
      case u:upto(_, b, _) => normalizeUpto(u, b)
    }
  }
  while (stat != old);
  return stat;
}

public test bool testBlockFlattening1() = normalize(block([block([])])) == block([]);
public test bool testBlockFlattening2() = 
   normalize(block([assign([], string()), block([]), assign([], string())])) 
      == block([assign([], string()), assign([], string())]);

public Stat prefixPath(Stat stat, Path prefix) = visit (stat) { case Path path => prefix + path };

public Stat normalizeUpto(upto(x, 0, s), int cnt) =
   prefixPath(s,  x + [subscript(cnt - 1)]);
   
public default Stat normalizeUpto(upto(x, n, s), int cnt) {
  curPath = x + [subscript(cnt - n)];
  return block([
    prefixPath(s, curPath),
    ifThen(path(curPath), normalizeUpto(upto(x, n - 1, s), cnt))
  ]);
} 

public Stat nestedUpto = upto([field("x")], 4, upto([field("nested_z")], 2, assign([field("a")], string())));

public test bool testUpto1() {
  a = assign([field("y")], string());
  u = upto([field("nested_z")], 2, assign([field("a")], string()));
  // mimick innermost
  u2 = normalizeUpto(u, 2);
  stat = upto([field("x")], 4, u2);
  iprintln(normalizeUpto(stat, 4));
  return true;
}

//public Stat normalizeIter(upto(x, 0,  s), int cnt) = if(path(subscript(x, cnt)
//  if(path(subscript(
//}

data Exp
  = path(Path path)
  | \bool(bool b)
  | \int(int n)
  | string(str s)
  | \any(list[Exp] conds)
  | \all(list[Exp] conds)
  | sum(Exp goal, list[Exp] conds)
  | avg(Exp goal, list[Exp] conds)
  | field(Exp target, str field)
  | pos(Exp arg)
  | neg(Exp arg)
  | not(Exp arg)
  | pow(Exp lhs, Exp rhs)
  | mul(Exp lhs, Exp rhs)
  | div(Exp lhs, Exp rhs)
  | mod(Exp lhs, Exp rhs)
  | add(Exp lhs, Exp rhs)
  | sub(Exp lhs, Exp rhs)
  | lt(Exp lhs, Exp rhs)
  | gt(Exp lhs, Exp rhs)
  | leq(Exp lhs, Exp rhs)
  | geq(Exp lhs, Exp rhs)
  | \in(Exp lhs, Exp rhs)
  | \notin(Exp lhs, Exp rhs)
  | eq(Exp lhs, Exp rhs)
  | neq(Exp lhs, Exp rhs)
  | and(Exp lhs, Exp rhs)
  | or(Exp lhs, Exp rhs)
  ;