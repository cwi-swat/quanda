module Quanda

import util::Prompt;
import IO;

/* Notes

- Grouping is sugar: the condition on the group is added to the conditions
  on the contained rules (conjunction)

- For revision: re-evaluate the conditions on the rules that already have been
  answered, if the condition becomes false, its variable becomes "unknown"
  (removed from env) then transitively disable rules having conditions referencing
  the variable of the false-become rule. Use three-valued logic.
  
- The model of qa is a kind of XML-Schema (nesting, optionality, enums). If nesting
  is not desugared, we need to have a kind of XPath exps in conditions to query the model.
  
Extensions

 - Recursion:  x => rec x { c: "";  c => "" } When unfolding rename all vars that
   are assigned in the body to new (primed') variables. We want recursion to model
   lists of answers.
   
 - repeat:  x => repeat { RS } -x--> prime(RS) x => repeat { .. }
    hasComment: "Comment?"   // R1
    repeat {   // R2
       hasComment => c: "Enter a comment"  // R3
    }
    step 1:  R1 is enabled, user says yes, R1 is removed
    step 2: R2 fires, hence R3 + R2 are in next, user enters a comment
    step 3: R3 is removed

 - multiple assignments (is this really needed?), expressions (can be desugared into 
   computing rules.
 
 - computed rules: x = a + b, x becomes bound as soon as all its variables are in the
   env. Spreadsheet subsystem.
   
 - conditional values in types. E.g. conditionally adding an option to a dropdown.
   this addition, must not invalidate previous decisions (does it ever?)
 
 - belief probability propagation: bayesian network. Don't measure influence twice.
   Conditional independence. 

Checking:

- no two rules that assign the same variable can be enabled at the same time
  (check for contradication on conjunction of guards). If we allow <, >, == etc
  we need finite domain constraint solving. (is this conditional independence?)
  
- type checking
  
- unreachable questions: if ref a var never assigned anywhere (trivial). For finite
  domains we need some kind of abstract interpretation. E.g. types could be: [1..100],
  one-of(A, B, C), more-of, bool etc.  We can then analyse if there are paths through
  the qa that will enable its conditions. Related: no cycles in the reachability graph.

- Single assignment means, no question can be reenabled after it has been ansewered.

Rendering

 - What is rendered is a projection from the qa: answered questions are uneditable,
   enabled questions are visible and editable, disabled questions are invisible.
   Computed values are uneditable and greyed until they are computed. 

- If the user fills in some questions, this leads to bindings: question -> value,
  the questions in the domain become answered, each questions' variable obtains the
  answer value in the environment.
  
 - in the case of revision there are re-answered questions and answered questions. The 
   first set triggers a recomputation of dependent questions, clear and/or disables them
   if needed (or gives an error). The revised answers should not conflict with new answers (?).
   Upon revision, we need as much sharing of the previous state as possible.
  
TODO: what is our difference from XForms?

Research challenges

- Evolution: merging, migration etc.
- Modularity/compositionality, inheritance
- Impl of the DSL: how to separate layout stuff from logic.
- constraint solving for checking stuff.
*/


// a question has a condition, a variable it assigns to and a label (the question).
data Question 
  = question(Expression cond, str var, str label)
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
question(eq(var("vo"), const("WO")), "uni", "Wat is de universiteit?") 
];


value eval(Env env, const(v))  = v;
value eval(Env env, eq(l, r))  = eval(env, l) == eval(env, r);
value eval(Env env, and(l, r)) = true := eval(env, l) && true := eval(env, r);
value eval(Env env, or(l, r))  = true := eval(env, l) || true := eval(env, r);
value eval(Env env, var(n))    = env[n] ? false; 

list[Question] next(Env env, list[Question] qs) =
  [ q | q <- qs, eval(env, q.cond) == true ];

Env ask(Env env, list[Question] qs) = 
  (env | it + (q.var: prompt(q.label)) | q <- qs );

// to simulate, make set[map[QName, Answer]] answers a param
// then instead of ask, we can answer directly and obtain the
// answered questions. This way you don't have to answer all
// enabled questions in one iteration.
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
