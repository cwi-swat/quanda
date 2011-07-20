module Quanda

import util::Prompt;
import IO;


// a question has a condition, a variable it assigns to and a label (the question).
data Question 
  = question(Expression cond, str var, str label)
  | \repeat(Expression cond, str var, str label)
  ;

data Expression 
  = eq(Expression lhs, Expression rhs)
  | and(Expression lhs, Expression rhs)
  | or(Expression lhs, Expression rhs)
  | var(str name)
  | const(value val)
  ;

alias Env = map[str var, value val];


public list[Question] Q = [
question(const(true), "vo", "Wat is je vooropleiding?"),
question(eq(var("vo"), const("HBO")), "sc", "Moet je schakelen?"),
question(eq(var("sc"), const("ja")), "cijfer", "Wat is je cijfer?"),
question(const(true), "lt", "Hoe oud ben je?"),
question(and(eq(var("vo"), const("WO")), eq(var("lt"), const("17"))), "wz", "Weet je het zeker?"),
question(eq(var("vo"), const("WO")), "uni", "Wat is de universiteit?"), 
\repeat(const(true), "hcom", "Commentaar?"),
question(eq(var("hcom"), const("ja")), "com", "Je commentaar: ")
];


value eval(Env env, const(v))  = v;
value eval(Env env, eq(l, r))  = eval(env, l) == eval(env, r);
value eval(Env env, and(l, r)) = true := eval(env, l) && true := eval(env, r);
value eval(Env env, or(l, r))  = true := eval(env, l) || true := eval(env, r);
value eval(Env env, var(n))    = env[n] ? false; 

list[Question] next(Env env, list[Question] qs) {
  result = [];
  for (q <- qs) {
    switch (q) {
      case \repeat(qs2): result += next(env, qs2);
      default: if (eval(env, q.cond) == true)
                 result += [q];
    }
  }
  return result;
}

Env ask(Env env, list[Question] qs) = 
  (env | it + (q.var: prompt(q.label)) | q <- qs );

// to simulate, make set[map[QName, Answer]] answers a param
// then instead of ask, we can answer directly and obtain the
// answered questions. This way you don't have to answer all
// enabled questions in one \repeatation.
public Env eval(Env env, list[Question] qs) {
  nxt = [];
  solve (qs) { 
    nxt = next(env, qs);
    println("NXT = <nxt>");
    env = ask(env, nxt); 
    qs -= nxt; 
  }
  return env;
}
