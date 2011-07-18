module AC3

import Set;
import Map;
import IO;

// TODO: to use this in Quanda, we might need to restrict conditions
// to be conjunctions only (no disjunction/negation).
// For dealing with numbers, we need interval repr. of domains.

data Constraint
  = eq(str x, value val)
  | even(str x)
  | add(str x, str y, value val)
  ; 
  
public bool satisfy(Env env, Constraint c) {
  switch (c) {
    case eq(x, v): return env[x] == v;
    case even(x): return env[x] % 2 == 0;
    case add(x, y, v): return env[x] + env[y] == v;
  }
}

alias Unary = rel[str x, Constraint constraint];
alias Binary = rel[str x, str y, Constraint constraint];

alias Env = map[str var, int val];
alias Domains = map[str, set[int]];

public Domains D = ("x": {0,1,2,3,4,5}, "y": {0,1,2,3,4,5});

// These relations must be (surjective) functions
// x = even, x + y = 4
public Unary R1 = {<"x", even("x")>};
public Binary R2 = {<"x", "y", add("x", "y", 4)>, <"y", "x", add("x", "y", 4)>};

public Domains ac3(Domains d, Unary r1, Binary r2, bool (Env, Constraint) sat) {
  bool arcReduce(str x, str y) {
    change = false;
    for (vx <- d[x]) {
      if (vy <- d[y], c <- r2[x, y], sat((x: vx, y: vy), c))
        ; 
      else {
        d[x] -= {vx};
        change = true;
      }
    }
    return change;
  }
  
  for (x <- domain(d), c <- r1[x]) 
    d[x] = { vx | vx <- d[x], sat((x: vx), c) };
  
  worklist = r2<0, 1>;
  do {
    <<x, y>, worklist> = takeOneFrom(worklist);
    if (arcReduce(x, y)) {
      if (d[x] == {}) 
        return d;

      worklist += { <z, x> | <z, x, _> <- r2, z != y }
        + { <z, x> | <x, z, _> <- r2, z != y }; 
    }
  } 
  while (worklist != {});
 
  return d;
}


