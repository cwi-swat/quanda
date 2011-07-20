module AST


data Form 
  = form(str name, list[Section] sections)
  ;

data Section 
  = section(list[Rule] rules)
  ;

data Rule
  = \rule(list[Exp] conds, Stat stat)
  | \rule(Stat stat)
  ;

public Rule \rule(Stat s) = \rule([], s);  

data Stat 
  = group(list[Rule] rules)
  | \repeat(Exp exp, Rule arg)
  | select(Var var, list[Case] cases)
  | input(Var var, Widget widget)
  | output(str label, Widget widget, Exp exp)
  ;

data Var
  = var(str name)
  | subscript(Var var, int i)
  ;

data Case 
  = when(list[Exp] conds, Widget widget)
  | otherwise(Widget widget)
  ;

data Widget 
  = button(str label)
  | text(str label)
  | number(str format, str label)
  | range(int from, int to, str label)
  | check(str label)
  | oneOf(str label, list[Option] options)
  | moreOf(str label, list[Option] options)
  ;
  
data Option
  = option(str key, str label)
  | option(Exp cond, str key, str label)
  ;
  
data Exp
  = lookup(Var var)
  | boolean(bool val)
  | number(int val)
  | string(str val)
  | defined(str var)
  | not(Exp arg)
  | neg(Exp arg)
  | add(Exp lhs, Exp rhs)
  | sub(Exp lhs, Exp rhs)
  | mul(Exp lhs, Exp rhs)
  | div(Exp lhs, Exp rhs)
  | and(Exp lhs, Exp rhs)
  | or(Exp lhs, Exp rhs)
  | gt(Exp lhs, Exp rhs)
  | lt(Exp lhs, Exp rhs)
  | geq(Exp lhs, Exp rhs)
  | leq(Exp lhs, Exp rhs)
  | neq(Exp lhs, Exp rhs)
  | eq(Exp lhs, Exp rhs)
  | exist(list[Exp] args)
  | forall(list[Exp] args)
  ;
