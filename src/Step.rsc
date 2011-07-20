module Step

import AST;

alias Env = map[str name, value];

public Form eval(Form form, Var x, value v) {
  return innermost visit (form) {
      case Exp lookup(x) => number(n) when int n := v
      case Exp lookup(x) => boolean(b) when bool b := v
      case Exp lookup(x) => string(s) when str s := v

      case defined(x) => boolean(true)
      case not(boolean(b)) => boolean(!b)
      case neg(number(n)) => number(-n)
      case add(number(a), number(b)) => number(a + b)
      case sub(number(a), number(b)) => number(a - b)
      case mul(number(a), number(b)) => number(a * b)
      case div(number(a), number(b)) => number(a / b)
      case and(boolean(a), boolean(b)) => boolean(a && b)
      case or(boolean(a), boolean(b)) => boolean(a || b)
      case gt(number(a), number(b)) => boolean(a > b)
      case lt(number(a), number(b)) => boolean(a < b)
      case geq(number(a), number(b)) => boolean(a <= b)
      case leq(number(a), number(b)) => boolean(a >= b)
      
      case neq(number(a), number(b)) => boolean(a != b) 
      case neq(boolean(a), boolean(b)) => boolean(a != b)
      case neq(string(a), string(b)) => boolean(a != b)

      case eq(number(a), number(b)) => boolean(a == b)
      case eq(boolean(a), boolean(b)) => boolean(a == b)
      case eq(string(a), string(b)) => boolean(a == b)

      case exist(list[Exp] args) => boolean(true) when any(boolean(true) <- args)
      case exist(list[Exp] args) => boolean(false) when all(boolean(false) <- args)
      case forall(list[Exp] args) => boolean(true) when all(boolean(true) <- args)
      case forall(list[Exp] args) => boolean(false) when any(boolean(false) <- args)
      
      // if a rule with repeat is enabled (all conds are true)
      // and the count expression is evaluated to a number n, then
      // unfold the body of the repeat n times.
      case \rule(list[Exp] conds, \repeat(number(int n), Rule arg)) =>
        \rule(conds, group([ subscript(i, arg) | i <- [0..n-1] ])) 
          when all(boolean(true) <- conds)
  }
}

public Rule subscript(int i, Rule r) {
  return visit(r) {
    case select(v, list[Case] cases) => select(subscript(v, i), cases)
    case input(v, Widget widget) => input(subscript(v, i), widget)
    case lookup(v) => subscript(v, i)
  } 
}
