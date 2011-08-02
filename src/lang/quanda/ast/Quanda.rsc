module lang::quanda::ast::Quanda


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
  | doc(str content)
  | tip(str content)
  | ref(str label, str anchor)
  | label(str anchor)
  | link(str label, str url)
  | section(str label, Statement body)
  | group(str label, Statement body)
  | par(Statement body)
  | \list(Statement body)
  | \item(Statement body)
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
