module lang::daspec::util::Load

import lang::daspec::util::Parse;
import lang::daspec::util::Implode;
import lang::daspec::model::Datum;

import IO;
import ParseTree;
import String;

public list[Datum] loadDatums(list[int] keys) {
  return for (k <- keys) {
    try {
      append loadDatum(k);
    }
    catch IllegalArgument(Tree t, str msg): {
      println("WARNING ambiguity \"<t>\": <msg>");
    } 
  }
}

public Datum loadDatum(int key) =
  implodeDatum(parseDatum(|project://quanda/input/<s>.das|))
  when s := "<key>";

public list[Datum] loadAll() {
  datums = listEntries(|project://quanda/input|);
  keys = [ toInt(key) | d <- datums, /^<key:[0-9]+>\.das$/ := d ];
  return loadDatums(keys);
}