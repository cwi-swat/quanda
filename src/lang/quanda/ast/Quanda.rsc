module lang::quanda::ast::Quanda


anno loc Form@location;
anno loc Declaration@location;
anno loc Statement@location;
anno loc Widget@location;
anno loc Range@location;
anno loc Enum@location;
anno loc Option@location;

data Form
  = form(list[Declaration] decls)
  ;
  
data Declaration
  = options(str name, list[tuple[str, Type]] formals, list[Option] options)
  | def(str name, list[tuple[str, Type]] formals, list[Statement] body)
  ;
  
data Statement
  = \if(Expression cond, Statement body)
  | \if(Expression cond, Statement body, Statement elseBody)
  | \for(Expression generator, Statement body)
  | \switch(Expression exp, list[tuple[Expression, Statement]] cases)
  | block(list[Statement] statements)
  | doc(str content)
  | tip(str content)
  | ref(str label, str anchor)
  | label(str anchor)
  | link(str label, str url)
  | section(str label, Statement body)
  | group(str label, Statement body)
  | par(Statement body)
  | \list(Statement body)
  | item(Statement body)
  | stack(Statement body)
  | card(Statement body)
  | table(Statement body)
  | row(Statement body)
  | col(Statement body)
  | string(str \value)
  | output(Expression exp)
  | bind(str var, Widget widget)
  | \repeat(str var, Expression bound, Statement body)
  | with(str var, str field, Statement body)
  | call(str name, list[Expression] args)
  | let(str name, Expression arg)
  ;

data Expression
  = var(str name)
  | \bool(bool b)
  | \int(int n)
  | string(str s)
  | \any(list[Expression] conds)
  | \all(list[Expression] conds)
  | sum(Expression goal, list[Expression] conds)
  | avg(Expression goal, list[Expression] conds)
  | field(Expression target, str field)
  | pos(Expression arg)
  | neg(Expression arg)
  | not(Expression arg)
  | pow(Expression lhs, Expression rhs)
  | mul(Expression lhs, Expression rhs)
  | div(Expression lhs, Expression rhs)
  | mod(Expression lhs, Expression rhs)
  | add(Expression lhs, Expression rhs)
  | sub(Expression lhs, Expression rhs)
  | lt(Expression lhs, Expression rhs)
  | gt(Expression lhs, Expression rhs)
  | leq(Expression lhs, Expression rhs)
  | geq(Expression lhs, Expression rhs)
  | \in(Expression lhs, Expression rhs)
  | \notin(Expression lhs, Expression rhs)
  | eq(Expression lhs, Expression rhs)
  | neq(Expression lhs, Expression rhs)
  | and(Expression lhs, Expression rhs)
  | or(Expression lhs, Expression rhs)
  ;

data Widget
  = radio(Enum enum)
  | dropdown(Enum enum)
  | spin(Enum enum)
  | select1(Enum enum)
  | check(Enum enum)
  | select(Enum enum)
  | check1()
  | button(str label)
  | slider(Range range)
  | text()
  | text(int size)
  | numeric()
  | numeric(str format)
  | area(int width, int height)
  | date()
  ;

data Range
  = range(Expression from, Expression to)
  | range(Expression from, Expression next, Expression to)
  ;  
  
data Enum
  = inline(list[Option] options)
  | call(str name, list[Expression] args)
  ;
  
data Option
  = option(str key, str label)
  | option(str key, str label, Expression condition)
  ;

  
data Type
  = integer()
  | currency()
  | boolean()
  | date()
  | time()
  | string()
  | user(str name)
  ;
