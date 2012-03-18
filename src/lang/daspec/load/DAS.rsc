module lang::daspec::load::DAS

import lang::csv::ast::CSV;
import lang::csv::IO;

import String;
import List;
import IO;
import Message;

public loc DACSV = 
 |project://quanda/cases/specs/da2011/1.4/2%20Gegevensspecificaties/CSV%20-%20Gegevensspec%20da2011%20IH%20VPB%20v2.3%2020110929.csv|;

alias DASRecord = tuple[
  str naam, 
  int identificatienummer, 
  str definitie, 
  str toelichting, 
  str formaat, 
  str condities, 
  str domein, 
  str heeftrelatiemet, 
  str bron, 
  str tellingen, 
  str berekeningswijzes,
  loc location];

alias DASTable = list[DASRecord];

public tuple[DASTable, set[Message]] table2dasTable(Table tbl) {
  errs = {};
  width = 11;
  result = for (r:record(fs) <- tail(tbl.records)) {
    if (size(fs) != width) {
      errs += {warning("record has incorrect number of fields (<size(fs)> vs <width>)", r@location)};
    }
    else {
      append <fs[0].text, toInt(fs[1].text), fs[2].text, fs[3].text, fs[4].text,
              fs[5].text, fs[6].text, fs[7].text, fs[8].text, fs[9].text,
              fs[10].text, r@location>;
    }
  }
  return <result, errs>;
}
  
public tuple[DASTable, set[Message]] loadDASTable() = table2dasTable(unquote(loadCSV(DACSV)));
  
