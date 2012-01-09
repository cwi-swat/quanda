module lang::daspec::format::Expr2Box

import lang::daspec::model::Expr;
import lang::daspec::format::Utils;
import lang::box::util::Box;
import lang::box::util::Box2Text;


public Box expr2box(call(n, arg)) = H([L("#<n>"), L("("), expr2box(arg), L(")")])[@hs=0];

public Box expr2box(ref(r)) = expr2box(r);

public Box expr2box(const(v)) = expr2box(v);

public Box expr2box(sum(e)) = H([KW(L("som")), L("("), expr2box(e), L(")")])[@hs=0];

public Box expr2box(abs(e)) = H([KW(L("abs")), L("("), expr2box(e), L(")")])[@hs=0];

public Box expr2box(right(a1, a2)) = func("rechts", a1, a2);
public Box expr2box(left(a1, a2)) = func("links", a1, a2); 
public Box expr2box(max(a1, a2)) = func("max", a1, a2); 
public Box expr2box(min(a1, a2)) = func("min", a1, a2); 

public Box expr2box(pos(a)) = H([L("+"), expr2box(a)])[@hs=0];

public Box expr2box(add(lhs, rhs)) = H([expr2box(lhs), L("+"), expr2box(rhs)]);
public Box expr2box(sub(lhs, rhs)) = H([expr2box(lhs), L("-"), expr2box(rhs)]);
public Box expr2box(mul(lhs, rhs)) = H([expr2box(lhs), L("*"), expr2box(rhs)]);
public Box expr2box(div(lhs, rhs)) = H([expr2box(lhs), L("/"), expr2box(rhs)]);
public Box expr2box(eq(lhs, rhs)) = H([expr2box(lhs), L("="), expr2box(rhs)]);
public Box expr2box(leq(lhs, rhs)) = H([expr2box(lhs), L("\<="), expr2box(rhs)]);
public Box expr2box(geq(lhs, rhs)) = H([expr2box(lhs), L("\>="), expr2box(rhs)]);
public Box expr2box(gt(lhs, rhs)) = H([expr2box(lhs), L("\>"), expr2box(rhs)]);
public Box expr2box(lt(lhs, rhs)) = H([expr2box(lhs), L("\<"), expr2box(rhs)]);

public Box expr2box(defined(a)) = func("Gevuld", a);
public Box expr2box(isDefined(a)) = func("is.gevuld", a);
public Box expr2box(isUndefined(a)) = func("is.leeg", a);

public Box expr2box(and(as)) = func("en", as);
public Box expr2box(or(as)) = func("of", as); 
  
// put exp between box and expr2 then all results filtered
public Box expr2box(ifThen(c, a)) = 
  V([
    H([KW(L("Als")), expr2box(c)]),
    KW(L("dan")),
    I([expr2box(a)])
  ]);
  

public Box expr2box(ref(k, v, n, s)) = 
  H([
    L("["), L("<k>"), L("."), expr2box(v), L("]"),
    L("\<"), L("<n>"), L("."), exp2box(s), L("\>")
  ])[@hs=0];

public Box expr2box(ref(k, n)) = 
  H([
    L("["), L("<k>"), L("]"),
    L("\<"), L("<n>"), L("\>")
  ])[@hs=0];


public Box expr2box(sym(s)) = STRING(L(s));
public Box expr2box(nat(n)) = L("<n>");


private Box func(str name, list[Exp] args...) =
  H([KW(L(name)), L("("), 
     H(sepList(L(";"), [ expr2box(a) | a <- args ])), 
     L(")")])[@hs=0];

  
  