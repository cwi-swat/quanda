module lang::daspec::format::Expr2Box

import lang::daspec::model::Expr;
import lang::daspec::format::Utils;
import lang::box::util::Box;
import String;
import List;

public Box expr2box(parseError(str src, loc l)) = 
  H([L("PARSE_ERROR"), COMM(H([L("/*"), 
    L(insertMarker(src, l)), 
    L("*/")]))])[@hs=1];

public str insertMarker(str src, loc l) {
  lines = split("\n", src);
  lineNo = l.begin.line;
  line = lines[lineNo - 1];
  left = substring(line, 0, l.begin.column);
  right = substring(line, l.begin.column, size(line));
  lines[lineNo - 1] = left + "\<ERROR\>" + right;
  return intercalate("\n", lines);  
}

public Box expr2box(call(n, arg)) = H([L("#<n>"), L("("), expr2box(arg), L(")")])[@hs=0];

public Box expr2box(Exp::ref(r)) = expr2box(r);

public Box expr2box(const(v)) = expr2box(v);

public Box expr2box(Exp::sum(e)) = H([KW(L("som")), L("("), expr2box(e), L(")")])[@hs=0];

public Box expr2box(abs(e)) = H([KW(L("abs")), L("("), expr2box(e), L(")")])[@hs=0];

public Box expr2box(yearOf(e)) = H([KW(L("jaar-uit")), L("("), expr2box(e), L(")")])[@hs=0];

public Box expr2box(Exp::right(a1, a2)) = func("rechts", [a1, a2]);
public Box expr2box(Exp::left(a1, a2)) = func("links", [a1, a2]); 
public Box expr2box(Exp::max(a1, a2)) = func("max", [a1, a2]); 
public Box expr2box(Exp::min(a1, a2)) = func("min", [a1, a2]); 

public Box expr2box(pos(a)) = H([L("+"), expr2box(a)])[@hs=0];

public Box expr2box(add(lhs, rhs)) = H([expr2box(lhs), L("+"), expr2box(rhs)])[@hs=1];
public Box expr2box(sub(lhs, rhs)) = H([expr2box(lhs), L("-"), expr2box(rhs)])[@hs=1];
public Box expr2box(mul(lhs, rhs)) = H([expr2box(lhs), L("*"), expr2box(rhs)])[@hs=1];
public Box expr2box(div(lhs, rhs)) = H([expr2box(lhs), L("/"), expr2box(rhs)])[@hs=1];
public Box expr2box(eq(lhs, rhs)) = H([expr2box(lhs), L("="), expr2box(rhs)])[@hs=1];
public Box expr2box(leq(lhs, rhs)) = H([expr2box(lhs), L("\<="), expr2box(rhs)])[@hs=1];
public Box expr2box(geq(lhs, rhs)) = H([expr2box(lhs), L("\>="), expr2box(rhs)])[@hs=1];
public Box expr2box(gt(lhs, rhs)) = H([expr2box(lhs), L("\>"), expr2box(rhs)])[@hs=1];
public Box expr2box(lt(lhs, rhs)) = H([expr2box(lhs), L("\<"), expr2box(rhs)])[@hs=1];

public Box expr2box(inc(lhs, rhs)) = H([expr2box(lhs), L("=+"), expr2box(rhs)])[@hs=1];
public Box expr2box(dec(lhs, rhs)) = H([expr2box(lhs), L("=-"), expr2box(rhs)])[@hs=1];

public Box expr2box(defined(a)) = func("Gevuld", [a]);
public Box expr2box(isDefined(a)) = func("is.gevuld", [a]);
public Box expr2box(isUndefined(a)) = func("is.leeg", [a]);

public Box expr2box(and(as)) = func("en", as);
public Box expr2box(or(as)) = func("of", as); 
  
// put exp between box and expr2 then all results filtered
public Box expr2box(ifThen(c, a)) = 
  V([
    H([KW(L("Als")), expr2box(c)]),
    KW(L("dan")),
    I([expr2box(a)])
  ]);
  


public str normalize(str s) = trim(squeeze(replaceAll(s, "\n", " "), " ")); 

public Box expr2box(Ref::ref(k, v, n, s)) = 
  H([
    L("["), L("<k.key>"), L("."), expr2box(v), L("]"),
    L("\<"), L(normalize(n)), expr2box(s), L("\>")
  ])[@hs=0];

public Box expr2box(Ref::ref(k, n)) = 
  H([
    L("["), L("<k.key>"), L("]"),
    L("\<"), L(normalize(n)), L("\>")
  ])[@hs=0];

public Box expr2box(field(n, txt)) = H([L("."), L(n), L("."), L(txt)])[@hs=0];

public Box expr2box(field(n)) = H([L("."), L(n)])[@hs=0];
public Box expr2box(\value(txt)) = H([L(".."), L(txt)])[@hs=0];

public Box expr2box(sym(s)) = STRING(L(s));
public Box expr2box(nat(n)) = L("<n>");
public Box expr2box(string(s)) = L(s);

private Box func(str name, list[Exp] args) =
  H([KW(L(name)), L("("), 
     HOV(sepList(L(";"), [ expr2box(a) | a <- args ]))[@hs=1], 
     L(")")])[@hs=0];

  
  