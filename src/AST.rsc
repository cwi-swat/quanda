module AST


data Form 
  = form(str name, list[Section] sections)
  ;

data Section 
  = section(str name, str description, list[Rule] rules)
  ;

data Rule
  = \rule(Exp cond, Stat stat)
  ;

data Stat 
  = group(list[Rule] rules)
  | \repeat(Var var, Exp count, Rule arg)
  | select(Var var, list[Case] cases)
  | input(Var var, Widget widget)
  | output(Widget widget, Exp exp)
  ;

data Var
  = var(str name)
  | subscript(Var var, int index)
  | field(Var var, str name)
  ;

data Case 
  = when(Exp cond, Widget widget)
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
  | boolean(bool b)
  | number(int n)
  | string(str s)
  | defined(Var var)
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
  | exist(Exp coll, Exp cond)
  | forall(Exp coll, Exp cond)
  ;
