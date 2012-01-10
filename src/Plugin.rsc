module Plugin

import util::IDE;
import ParseTree;
//import lang::quanda::syntax::Quanda;
//import RegelSpraak;
import lang::daspec::syntax::Datum;
import lang::daspec::syntax::Expr;
import lang::daspec::syntax::Lexical;
import lang::daspec::syntax::TOC;
import lang::daspec::IDE;

public void main() {
  //registerLanguage("Quanda", "qna", Form(str input, loc org) {
  //  return parse(#Form, input, org);
  //});
  //registerLanguage("TaxSpec", "tax-spec", start[Spec](str input, loc org) {
  //  return parse(#start[Spec], input, org);
  //});
  //registerLanguage("RegelSpraak", "rs", start[Spec](str input, loc org) {
  //  return parse(#start[Spec], input, org);
  //});
  
  registerLanguage("DASpec", "das", start[Datum](str input, loc org) {
    return parse(#start[Datum], input, org);
  });
  registerAnnotator("DASpec", annotateHyperlinks);
  registerLanguage("TOC", "toc", start[TOC](str input, loc org) {
    return parse(#start[TOC], input, org);
  });
}