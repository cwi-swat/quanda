module lang::mq::AST

import IO;

alias Path = list[PathElt];

data MQ = mq(list[Stat] stats);

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
  

data Type = string() | integer() | money();  
  
data Exp
  = path(Path path)
  | \bool(bool b)
  | nat(int n)
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
  

