module lang::daspec::format::Group2Box

extend lang::daspec::format::Datum2Box;
import lang::daspec::model::Group;
import lang::box::util::Box;
import lang::box::util::Box2Text;

public Box datum2box(group(name, kids)) = 
  V([
     H([KW(L("groep")), L(name), L("{")]),
     I([V([ datum2box(s) | s <- kids ])]),
     L("}")
   ]);
