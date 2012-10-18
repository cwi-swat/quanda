module lang::daspec::format::Spec2Box

extend lang::daspec::format::Group2Box;

import lang::daspec::model::Spec;

import lang::box::util::Box;
import lang::box::util::Box2Text;


public Box spec2box(spec(typ, version, kids)) =
  V([
     H([KW(L("model")), L(typ), L(version), L("{")]),
     I([ datum2box(k) | k <- kids ]),
     L("}")
   ]);