module lang::daspec::IDE

import lang::daspec::syntax::Datum;
import lang::daspec::syntax::Expr;

import ParseTree;
import IO;

anno set[loc] start[Datum]@links;
anno loc Key@links;


public start[Datum] annotateHyperlinks(start[Datum] tree) {
  loc makeLoc(Key k) {
    s = "<k>";
    println("Annotating: <s>");
    return |project://quanda/input/<s>.das|;
  }
  return visit (tree) {
    case Key k => { rprintln(k[@link=makeLoc(k)]); k[@link=makeLoc(k)]; } 
  }
  //ast = implodeDatum(tree);
  //links = { |project://quanda/input/<s>.das| | /key(n) := ast, str s := "<n>" };
  //return tree[@links=links]; 
}

