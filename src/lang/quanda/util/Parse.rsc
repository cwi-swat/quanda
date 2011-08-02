module lang::quanda::util::Parse

import lang::quanda::syntax::Quanda;

import ParseTree;

public Form parse(loc l) {
  return parse(#Form, l);
}