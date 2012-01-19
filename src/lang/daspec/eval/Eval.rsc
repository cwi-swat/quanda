module lang::daspec::eval::Eval

import lang::daspec::model::Expr;
import IO;

// TODO: rename syntactic Value to Const

alias Env = map[Key, State];

// Use a relation, so that we can detect conflicting changes
// to the same keyed datum.
alias Updates = rel[Key, State]; 

data SValue
  = boolean(bool boolVal)
  | integer(int intVal)
  | float(real realVal)
  | string(str strVal)
  | null()
  ;

/*
Valid states for Datums.
Transitions:
 - enabled -> disabled (as a consequence of conditions)
 - enabled -> answered (as a consequence of user input)
 - enabled(true) -> enabled(false) (conditions)
*/

data State 
  = disabled(SValue svalue)
  | computed(SValue svalue) 
  | answered(SValue svalue)
  | enabled(bool optional)
  ;
  
public SValue valueOf(State s) = s has svalue ? s.svalue : null();
//public bool isDefinedState(State s) = valueOf(s) == null();
  
public Exp sanitize(Exp e) {
  return solve(e) {
    e = visit (e) {
      case isUndefined(and(as)) => and([isUndefined(a) | a <- as])
      case isUndefined(or(as)) => or([isUndefined(a) | a <- as])
      case isDefined(and(as)) => and([isDefined(a) | a <- as])
      case isDefined(or(as)) => or([isDefined(a) | a <- as])
      case eq(x, or(as)) => or([eq(x, a) | a <- as])
    }
  }
}

public default Updates enforce(Exp x, Env e) = {};

public Updates enforce(ifThen(c, a), Env e) =
  (boolean(true) := eval(c, e)) ? enforce(a, e) : {};

public Updates enforce(defined(ref(ref(k, _))), Env e) =
  {<k, enabled(false)>};

public Updates enforce(isDefined(ref(ref(k, _))), Env e) =
  {<k, enabled(false)>};

public Updates enforce(isDefined(ref(ref(k, sym(s), _, _))), Env e) =
  {<k, disabled(string(s))>};
  
public Updates enforce(isDefined(ref(ref(k, nat(n), _, _))), Env e) =
  {<k, disabled(integer(n))>};
  
public Updates enforce(isUndefined(ref(ref(k, _))), Env e) =
  {<k, disabled(null())>};

public Updates enforce(and(as), Env e) =
  ( {} | it + enforce(a, e) | a <- as ); 

public Updates enforce(eq(ref(ref(k, _)), a), Env e) =
  {<k, disabled(eval(a, e))>}; 

public Updates enforce(eq(a, ref(ref(k, _))), Env e) =
  {<k, disabled(eval(a, e))>}; 

public default Updates enforce(Exp e, Env e) {
  throw "Cannot enforce <exp>";
}


/*
 * Ordinary expression evaluation
 */

public default SValue eval(Exp x, Env e) = null();

public SValue eval(call(n, a), Env e) = 
  BUILTINS[n](eval(a, e));

// TODO: check this
public SValue eval(Exp::ref(ref(k, sym(s), _, _)), Env e) = 
  valueOf(e[k]) == string(s){ ? string(s) : null()
  when k in e;

public SValue eval(Exp::ref(ref(k, _)), Env e) = valueOf(e[k])
  when k in e;

public SValue eval(const(sym(s)), Env e) = string(s);
public SValue eval(const(nat(n)), Env e) = integer(s);

//  | sum(Exp arg)

public SValue eval(abs(a), Env e) = n < 0 ? integer(-n) : integer(n)
  when integer(n) := eval(a, e);
 
//  | right(Exp arg1, Exp arg2) 
//  | left(Exp arg1, Exp arg2)

public SValue eval(max(a, b), Env e) = i > j ? integer(i) : integer(j)
  when integer(i) := eval(a, e), integer(j) := eval(b, e);

public SValue eval(min(a, b), Env e) = i < j ? integer(i) : integer(j)
  when integer(i) := eval(a, e), integer(j) := eval(b, e);
  
public SValue eval(pos(a), Env e) = n
  when integer(n) := eval(a, e);
  
public SValue eval(add(a, b), Env e) = integer(i + j)  
  when integer(i) := eval(a, e), integer(j) := eval(b, e);
  
public SValue eval(sub(a, b), Env e) = integer(i - j)  
  when integer(i) := eval(a, e), integer(j) := eval(b, e);
  
public SValue eval(mul(a, b), Env e) = integer(i * j)  
  when integer(i) := eval(a, e), integer(j) := eval(b, e);
  
public SValue eval(div(a, b), Env e) = integer(i / j)  
  when integer(i) := eval(a, e), integer(j) := eval(b, e);
  
public SValue eval(eq(a, b), Env e) = boolean(x == y)  
  when x := eval(a, e), y := eval(b, e);

public SValue eval(geq(a, b), Env e) = boolean(x >= y)  
  when x := eval(a, e), y := eval(b, e);

public SValue eval(leq(a, b), Env e) = boolean(x <= y)  
  when x := eval(a, e), y := eval(b, e);

public SValue eval(gt(a, b), Env e) = boolean(x > y)  
  when x := eval(a, e), y := eval(b, e);

public SValue eval(lt(a, b), Env e) = boolean(x < y)  
  when x := eval(a, e), y := eval(b, e);

public SValue eval(isDefined(a), Env e) =  boolean(eval(a, e) != null());

public SValue eval(isUndefined(a), Env e) = boolean(eval(a, e) == null());

public SValue eval(and(as), Env e) =
  boolean(( true | it && b | a <- as, boolean(b) := eval(a, e) ));
  
public SValue eval(or(as), Env e) =
  boolean(( false | it || b | a <- as, boolean(b) := eval(a, e) ));
  

// Bug: this function should be before the map below.
public SValue elfProef(SValue arg) {
  throw "Not yet implemented";
}

public map[str, SValue(SValue)] BUILTINS = (
 "elfproef": elfProef
); 


  