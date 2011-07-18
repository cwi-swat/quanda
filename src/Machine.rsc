module Machine

import Quanda;
import Set;

alias State = tuple[set[Question] enabled, set[Question] answered];


public set[str] use(Question q) = { n | /var(n) <- q.cond }; 
public set[str] def(Question q) = { q.var };

alias Trans = rel[State, Question, State]; 

public Trans transitions(list[Question] qs) {
  initEnabled = { q | q:question(const(true), _, _) <- qs };
  states = {<initEnabled, {}>};
  Trans trans = {};

  set[Question] next(set[Question] an) {
    return { z | z <- qs, use(z) <= { def(q1) | q1 <- an } };
  }

  bool valid(State s) {
    return !any(q1 <- s.enabled, q2 <- s.enabled, q1 != q2, q1.var == q2.var) &&
       !any(q1 <- s.answered, q2 <- s.answered, q1 != q2, q1.var == q2.var);
  }
  
  solve(states, trans) {
    for (<en, an> <- states, q <- en, en2 <- power(next(an + {q}) - {an, q})) {
      newState = <en2 + en - {q}, an + {q}>;
      if (valid(newState)) {
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