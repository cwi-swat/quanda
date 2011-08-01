module Plugin

import util::IDE;
import ParseTree;
import lang::quanda::syntax::Quanda;

public void main() {
  registerLanguage("Quanda", "qna", Form(str input, loc org) {
    return parse(#Form, input, org);
  });
}