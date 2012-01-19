module lang::daspec::IDE

import lang::daspec::syntax::Datum;
import lang::daspec::syntax::Expr;

import ParseTree;

anno set[loc] start[Datum]@links;
anno loc Key@links;

public start[Datum] annotateHyperlinks(start[Datum] tree) {
  loc makeLoc(Key k) {
    s = "<k>";
    return |project://quanda/input/<s>.das|;
  }
  return visit (tree) {
    case Key k => k[@link=makeLoc(k)] 
  }
}

