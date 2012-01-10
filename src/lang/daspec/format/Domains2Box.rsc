module lang::daspec::format::Domains2Box

import lang::daspec::model::Domains;
import lang::daspec::model::Datum;
import lang::daspec::model::Expr;
import lang::daspec::format::Expr2Box;
import lang::daspec::format::Utils;
import lang::box::util::Box;
import lang::box::util::Box2Text;

import lang::daspec::format::Datum2Box;
import lang::daspec::format::Expr2Box;
import IO;

public str formatDomains(Domains doms) = format(domains2box(doms));

public Box domains2box(domains(ds)) = A([ domains2box(d) | d <- ds ]);

public Box domains2box(decl(n, f, ms, rs)) = 
  R([L(n), L(":"), datum2box(f), 
     [str m] := ms ? L("[<m>]") : L(""), 
     [r] := rs ? domains2box(r) : L("")]);

public Box domains2box(enum(vs)) = 
  HV(sepList(L("|"), [ expr2box(v) | v <- vs ]))[@hs=0];

// somehow the integers a, b get a trailing .
public Box domains2box(range(num a, num b)) =
  H([L("<a>"), L(".."), L("<b>")])[@hs=1];

