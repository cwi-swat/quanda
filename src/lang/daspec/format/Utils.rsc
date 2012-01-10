module lang::daspec::format::Utils

import lang::box::util::Box;
import List;

public list[Box] sepList(Box sep, list[Box] elts) {
  if (elts == []) {
    return [];
  }
  lst = [ H([elt, sep])[@hs=0] | elt <- prefix(elts) ];
  return lst + [last(elts)];
}
