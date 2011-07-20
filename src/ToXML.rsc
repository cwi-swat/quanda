module ToXML

import XMLDOM;
import Machine;
import Quanda;

import Set;
import Relation;
import Graph;
import List;
import String;
import IO;

public void compile(list[Question] qs) {
  writeXMLPretty(|project://quanda/java/resources/example.xml|, quandaXML(qs));
}

public Node quandaXML(list[Question] qs)  {
  qids = questionIds(qs);
  return document(element("questionnaire", [
     element("initial", [charData(intercalate(" ", [ qids[q] | q <- qs, const(true) := q.cond ]))]), 
     questions(qs, qids)])); 
}



public Node questions(list[Question] qs, map[Question, str] qids) {
  nxt = next(qs);
  return element("questions", [
            element("question", [attribute("id", qids[q]), attribute("variable", q.var),
              element("condition", [charData(exp2js(q.cond))]),
              element("label", [charData(q.label)]),
              element("next", [charData(intercalate(" ", [ qids[q1] | q1 <- nxt[q] ]))])
               ]) | q <- qs ]);
}

public Node states(set[State] ss, Trans tr, map[State, str] ids, map[Question, str] qids) {
  result = element("states", []);
  
  for (State s1 <- ss) {
    elt = element("state", [attribute("id", ids[s1])]);
    elt.children += [element("enabled", [charData(intercalate(" ", [ qids[s] | s <- s1.enabled ]))])];
    elt.children += [element("answered", [charData(intercalate(" ", [ qids[s] | s <- s1.answered ]))])];

	te = element("transitions", []);

    srt = index(s1.enabled);
    te.children += for (v <- index(s1.enabled)) { 
      targets = sortBySize(toList(tr[s1, v]));
      goto = element("on", [attribute("answered", qids[v])]);
      goto.children += for (State s2 <- targets) {
        conds = [ qids[e] | e <- s2.enabled - s1.enabled ];
        append element("goto", [
        				attribute("guards", intercalate(" ", conds)),
        				attribute("target", ids[s2])]);
        
      }
      append goto;
    }
    
    elt.children += [te];
    result.children += [elt]; 
  }
  
  return result;
}
    


public map[Question, str] questionIds(list[Question] qs) {
  result = ();
  i = 0;
  for (q <- qs) {
    result[q] = "q<i>";
    i += 1;
  }
  return result;
}

public map[State, str] stateIds(set[State] ss) {
  result = ();
  i = 0;
  for (s <- ss) {
    result[s] = "s<i>";
    i += 1;
  }
  return result;
}

public list[Question] index(set[Question] qs) {
  return sort(toList(qs));
}

str exp2js(const(str v))  = "\"<v>\"";
str exp2js(const(int v))  = "<v>";
str exp2js(const(bool v))  = "<v>";
str exp2js(eq(l, r))  = "(<exp2js(l)> === <exp2js(r)>)";
str exp2js(and(l, r)) = "(<exp2js(l)>) && (<exp2js(r)>)"; 
str exp2js(or(l, r))  = "(<exp2js(l)>) || (<exp2js(r)>)";
str exp2js(var(n))    = n ;


public list[State] sortBySize(list[State] sl) {
  return sort(sl, bool (State a, State b) {
    return size(a.enabled) > size(b.enabled);
  });
}

