module lang::daspec::Sanity

import lang::daspec::Syntax;
import ParseTree;
import IO;

public list[loc] notparsing = 
[|project://quanda/input/117308.das|,|project://quanda/input/117512.das|,|project://quanda/input/117580.das|,
|project://quanda/input/117840.das|,|project://quanda/input/117841.das|,|project://quanda/input/623829.das|,
|project://quanda/input/623830.das|,|project://quanda/input/623831.das|,|project://quanda/input/623832.das|,
|project://quanda/input/623833.das|]
;


public list[loc] notParsing() {
  datums = listEntries(|project://quanda/input|);
  return for (d <- datums) {
    l = |project://quanda/input/<d>|;
    try {
      parse(#start[Datum], l);
    }
    catch _: {
      append l;
    }
  }
}
