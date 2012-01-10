module lang::daspec::IDE

import lang::daspec::syntax::Datum;
import lang::daspec::util::Implode;
import lang::daspec::model::Expr;

import ParseTree;

anno set[loc] start[Datum]@links;

public start[Datum] annotateHyperlinks(start[Datum] tree) {
  ast = implodeDatum(tree);
  links = { |project://quanda/input/<s>.das| | /key(n) := ast, str s := "<n>" };
  return tree[@links=links]; 
}

