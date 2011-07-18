module Compile

import Quanda;
import Machine;

import Set;
import Relation;
import Graph;
import List;
import String;
import IO;

public void compile(Trans tr) {
  writeFile(|project://quanda/output/src/Quanda.java|, quandaClass(tr));
}

public str quandaClass(Trans tr) {
  dep = tr<0, 2>;
  init = getOneFrom(top(dep));
  ss = carrier(dep);
  ids = stateIds(ss);
  return "import java.util.*;
         'import java.io.*;
         'public class Quanda {
         '  public static void main(String args[]) {
         '    Map\<String, String\> env = new HashMap\<String, String\>();
         '    Quanda q = new Quanda();
         '    q.dispatch(new Scanner(System.in), new PrintWriter(System.out), env);
         '    System.out.println(env);
         '  }
         '  
         '  <dispatchMethod(init, ss, ids)>
         '  <handleMethods(ss, tr, ids)>
         '  <renderMethods(ss, ids)>
         '}";
}

public str dispatchMethod(State init, set[State] ss, map[State, int] ids) {
  return "public void dispatch(Scanner input, PrintWriter output, Map\<String, String\> env) {
         '   int current = <ids[init]>;
         '   while (true) {
         '     switch (current) {
         '       <for (State s <- ss) {>
         '       case <ids[s]>: { 
         '         render_<ids[s]>(output, env);
         '         output.flush();
         '         <if (s.enabled != {}) {>
         '         int q = Integer.parseInt(input.nextLine());
         '         String a = input.nextLine();
         '         current = handle_<ids[s]>(env, q, a);
         '         break;
         '         <} else {>
         '         return;
         '         <}>
         '       }
         '       <}>
         '     }
         '  }
         '}
         ";
}

public str renderMethods(set[State] ss, map[State, int] ids) {
  result = for (State s <- ss) {
    srt = index(s.enabled);
    i = 0;
    append "public void render_<ids[s]>(PrintWriter output, Map\<String, String\> env) {
           '  <for (q <- s.answered) {>
           '  output.println(\"<q.label> \" + env.get(\"<q.var>\"));
           '  <}>
           '  <for (q <- srt) {>
           '  output.println(\"<i>: <q.label>\");
           '  < i += 1; }>
           '}";
  }
  return intercalate("\n", result);
}


public str handleMethods(set[State] ss, Trans tr, map[State, int] ids) {
  result = for (State s1 <- ss) {
    srt = index(s1.enabled); 
    j = 0;
    append "public int handle_<ids[s1]>(Map\<String, String\> env, int theQuestion, String theAnswer) {
           '  <for (v <- srt) {>
           '  if (theQuestion == <j>) {
           '    env.put(\"<v.var>\", theAnswer);
           '    <for (q <- ( {} | it + s2.enabled | State s2 <- tr[s1, v] ) - s1.enabled) {>
           '    boolean b_<qid(q)> = <exp2java(q.cond)>;
           '    <}>
           '    <for (State s2 <- sortBySize(toList(tr[s1, v]))) {>
           '    if (true <for (e <- s2.enabled - s1.enabled) {> && b_<qid(e)> <}>) {  
           '      return <ids[s2]>;
           '    }
           '    <}>
           '  }
           '  <j += 1; }>
           '  return -1;     
           '}";
  }
  return intercalate("\n", result);
}
  


public map[State, int] stateIds(set[State] ss) {
  result = ();
  i = 0;
  for (s <- ss) {
    result[s] = i;
    i += 1;
  }
  return result;
}

public list[Question] index(set[Question] qs) {
  return sort(toList(qs));
}

str exp2java(const(v))  = "\"<v>\"";
str exp2java(eq(l, r))  = "<exp2java(l)>.equals(<exp2java(r)>)";
str exp2java(and(l, r)) = "(<exp2java(l)>) && (<exp2java(r)>)"; 
str exp2java(or(l, r))  = "(<exp2java(l)>) || (<exp2java(r)>)";
str exp2java(var(n))    = "env.get(\"<n>\")"; 


public list[State] sortBySize(list[State] sl) {
  return sort(sl, bool (State a, State b) {
    return size(a.enabled) > size(b.enabled);
  });
}

public str qid(Question q) {
  return q.var;
}
