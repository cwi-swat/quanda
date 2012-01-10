module lang::daspec::model::Expr

// to deal with unparseable expressions
data Exp 
 = parseError(str src, loc l)
 ;    


data Key = key(int key);

data Exp
  = call(str name, Exp arg)
  | ref(Ref ref)
  | const(Value \value)
  | sum(Exp arg) 
  | abs(Exp arg)
  | right(Exp arg1, Exp arg2) 
  | left(Exp arg1, Exp arg2) 
  | max(Exp arg1, Exp arg2) 
  | min(Exp arg1, Exp arg2) 
  | pos(Exp arg)
  | add(Exp lhs, Exp rhs) 
  | sub(Exp lhs, Exp rhs) 
  | mul(Exp lhs, Exp rhs) 
  | div(Exp lhs, Exp rhs) 
  | eq(Exp lhs, Exp rhs) 
  | leq(Exp lhs, Exp rhs) 
  | geq(Exp lhs, Exp rhs) 
  | gt(Exp lhs, Exp rhs) 
  | lt(Exp lhs, Exp rhs)
  | defined(Exp arg)
  | isDefined(Exp arg)
  | isUndefined(Exp arg)
  | and(list[Exp] args)
  | or(list[Exp] args)
  | ifThen(Exp cond, Exp arg) 
  ;

data Ref
  = ref(Key key, Value \value, str name, Sub sub)
  | ref(Key key, str name)
  ;

data Value
  = sym(str strValue)
  | nat(int intValue)
  ;

data Sub
  = field(str name, str text)
  | field(str name)
  | \value(str text)
  ;
  