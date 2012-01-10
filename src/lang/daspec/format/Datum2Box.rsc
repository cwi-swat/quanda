module lang::daspec::format::Datum2Box

import lang::daspec::model::Datum;
import lang::daspec::format::Expr2Box;
import lang::daspec::format::Utils;
import lang::box::util::Box;
import lang::box::util::Box2Text;
import String;
import List;

public Box datum2box(datum(name, key, typ, body)) =
  V([
     H([KW(L("gegeven")), L(name), 
        H([H([L("["), L("<key>"), L("]")])[@hs=0], L(":")])[@hs=0], datum2box(typ), L("{")]),
     I([V([ datum2box(s) | s <- body ])]),
     L("}")
    ]);
    
    
public Box datum2box(Type::format(f)) = datum2box(f);

public Box datum2box(Type::domain(n)) = VAR(L(n));

public Box datum2box(alpha(n)) = KW(L("a<n>"));
public Box datum2box(alphaNumeric(n)) = KW(L("an<n>"));
public Box datum2box(alphaNumericUpTo(b)) = KW(L("an..<b>"));
public Box datum2box(numeric(n)) = KW(L("n<n>"));
public Box datum2box(numericUpTo(b)) = KW(L("n..<b>"));
  
public Box datum2box(page(no)) = H([KW(L("page")), L("<no>")]);

public Box datum2box(usedBy([])) = H([]); //H([KW(L("gebruikt")), KW(L("in"))]);

public Box datum2box(usedBy(ks)) =
  V([ 
     H([KW(L("gebruikt")), KW(L("in"))]),
     I([
       HV(sepList(L(","), [ L("<k>") | k <- ks ]))
     ])
  ])
  when size(ks) > 0;
 
 
public Box datum2box(condition([], exp)) = 
  V([KW(L("conditie")),
     I([expr2box(exp)])]);

public Box datum2box(condition([lab], exp)) = 
  V([H([KW(L("conditie")), H([L(lab), L(":")])[@hs=0]]),
     I([expr2box(exp)])]);

public Box datum2box(formula([], exp)) = 
  V([KW(L("bereken")),
     I([expr2box(exp)])]);

public Box datum2box(formula([lab], exp)) = 
  V([H([KW(L("bereken")), H([L(lab), L(":")])[@hs=0]]),
     I([expr2box(exp)])]);
        

public Box datum2box(definition(str txt)) = doc2box("definitie", txt);
public Box datum2box(explanation(str txt)) = doc2box("toelichting", txt);
public Box datum2box(source(str txt)) = doc2box("bron", txt);
public Box datum2box(algorithm(str txt)) = doc2box("bereken", txt);
  
private Box doc2box(str label, str txt) {
 words = [ L(w) | w <- split(" ", txt) ]; 
 return
   V([
     H([KW(L(label)), L("{")]),
     I([HV(words)]),
     L("}")
   ]);
}




  

