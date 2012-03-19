module lang::daspec::format::TOC2Box

import lang::daspec::model::TOC;
import lang::box::util::Box;
import lang::box::util::Box2Text;

public str formatTOC(TOC toc) = format(toc2box(toc));

public Box toc2box(TOC toc) = V([ toc2box(e) | e <- toc.entries ]);

public Box toc2box(section(t, es, p)) =
  V([
    H([KW(L("sectie")), STRING(L(t)), L("{")]),
    I([V(
      [ A([ toc2box(e) | e:datum(_, _) <- es ])] 
      + [ toc2box(e) | e:section(_, _, _) <- es ]
    )]),
    L("}")
  ]);

public Box toc2box(datum(n, k)) = 
   R([STRING(L(n)), H([L("["), NM(L("<k>")), L("]")])[@hs=0]]); 


