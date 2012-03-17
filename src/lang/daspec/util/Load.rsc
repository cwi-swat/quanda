module lang::daspec::util::Load

import lang::daspec::util::Parse;
import lang::daspec::util::Implode;
import lang::daspec::model::Datum;

import IO;
import ParseTree;
import String;

// TODO: use this
private loc DACSV = 
 |project://quanda/cases/specs/da2011/1.4/2%20Gegevensspecificaties/CSV%20-%20Gegevensspec%20da2011%20IH%20VPB%20v2.3%2020110929.csv|;

alias DAS =
  list[tuple[str naam, int identificatienummer, str definitie, str toelichting, str formaat, 
  str condities, str domein, str heeftrelatiemet, str bron, str tellingen, str berekeningswijzes]];
  
public DAS das() {
  return readCSV(#DAS, DACSV);
}  
  



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