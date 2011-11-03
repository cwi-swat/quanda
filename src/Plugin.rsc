module Plugin

import util::IDE;
import ParseTree;
//import lang::quanda::syntax::Quanda;
import lang::TaxSpec;

public void main() {
  //registerLanguage("Quanda", "qna", Form(str input, loc org) {
  //  return parse(#Form, input, org);
  //});
  registerLanguage("TaxSpec", "tax-spec", start[Spec](str input, loc org) {
    return parse(#start[Spec], input, org);
  });
}