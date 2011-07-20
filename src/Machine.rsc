module Machine

import Quanda;
import Set;
import IO;

alias State = tuple[set[Question] enabled, set[Question] answered];


public set[str] use(Question q) = { n | /var(n) <- q.cond } + (q is \repeat ? def(q) : {}); 
public set[str] def(Question q) = { q.var };

alias Trans = rel[State, Question, State]; 

public list[Question] COM = [
\repeat(const(true), "hc", "Comment?"),
question(eq(var("hc"), const("ja")), "c", "Comment:")
];



public rel[Question, Question] next(list[Question] qs) {
  result = {};
  for (q <- qs) {
    result += { <q, q1> | q1 <- qs, q.var in use(q1) };
    if (q is \repeat) {
      result += {<q, q>};
    }
  }
  return result;
} 
/*

next(q) = all q <- qs that use q.var
next(rep) = (all q < qs, that use q.var) + rep

*/

public Trans transitions(list[Question] qs) {
  initEnabled = { q | q:question(const(true), _, _) <- qs } +
     { q | q:\repeat(const(true), _, _) <- qs };
     
  states = {<initEnabled, {}>};
  Trans trans = {};

  dep = { <a, b> | a <- qs, b <- qs, def(b) <= use(a) };
  deptr = dep*;
  
  set[Question] next(set[Question] an) {
    return { z | z <- qs, use(z) <= { def(q1) | q1 <- an } };
  }

  powerCache = ();
  
  solve(states, trans) {
    for (<en, an> <- states, q <- en) {
      set[Question] bla;
      //set[Question] possibleNextQuestions = next(an + {q});
      if (any(<q, \repeat(_, _, _)> <- deptr)) {
        if (q is \repeat) {
		  as = { a | a <- an, !any(<a, q> <- deptr) };        
          bla = next(an + {q}) - as + {q};
        }
        else {
          bla = next(an + {q}) - an + {q};
        }  
        
      }
      else  {
        bla = next(an + {q}) - {an, q};
      }
      if (!powerCache[bla]?) {
        iprintln("power bla: <bla>");
        powerCache[bla] = power(bla);
      }
      for (en2 <- powerCache[bla]) {
	      State newState;
	      if (q is \repeat) {
	        newState = <en2 + en, an + {q}>;
	      }
	      else {
	        x = (en - {q}) + en2;
	        newState = <x, an + {q}>;
	      }
	      states += {newState};
	      trans += {<<en, an>, q, newState>};
	  }
	}
  }
  
  return trans;
}

public rel[rel[set[str],set[str]], str, rel[set[str],set[str]]] namedTrans(Trans tr) {
  return { <s1, q.var, s2> | <q1, q, q2> <- tr, s1 := namedStateSpace({q1}),
    s2 := namedStateSpace({q2}) };
}


public rel[set[str], set[str]] namedStateSpace(set[State] ss) {
  return { <en2, an2> | <en, an> <- ss, en2 := { q.var | q <- en },
  	an2 := { q.var | q <- an } };
}