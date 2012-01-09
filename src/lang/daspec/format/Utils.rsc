module lang::daspec::format::Utils

import lang::box::util::Box;

public list[Box] sepList(Box sep, list[Box] elts) {
  if (isEmpty(elts)) {
    return [];
  }
  lst = [ H([elt, sep])[@hs=0] | elt <- prefix(elts) ];
  return lst + [last(elts)];
}
