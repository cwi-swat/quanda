module lang::daspec::util::BMGCodes

import lang::csv::IO;
import List;
import IO;

private loc BMGCSV = 
 |project://quanda/cases/specs/da2011/1.4/2%20Gegevensspecificaties/mBMG%20DA2011%20v2_1_20110701.csv|;
 

// NB: last Code is path into XML Schema from Berichtspecificatie.
// AantHerh: 1 required, 0 means optional, 99 means maximally 99

alias BMGTable = list[BMGRecord];

alias BMGRecord = tuple[
  int Nivo, 
  int AantHerh, // mult
  int Id, // id (section)
  str GgrNaam, // name (section)
  int GelId, // id (element)
  str GelNaam, // (name element)
  str SubelCode, //  (field)
  str SubelNaam, //  (field)
  str DomwCode, // (value)
  str DomwNaam,  // (value)
  str Formaat, // format 
  str Masker, // mask
  str ImplemAanw, // hint 
  str MidNaam, // ??? 
  str Code, // path
   str a, str b, str c];


data Node
  = section(int id, str name, int mult, list[Node] kids)
  | element(int id, str name, 
       str format, str mask, str hint, str path,
       list[Field] fields,  
       list[Value] values);
  
alias Value = tuple[str code, str name];
alias Field = tuple[str code, str name];  
  
  
/*
To check:
- bmgs used in mapping are in DAS and vice versa
- herhalingen in BMG match those in XSD
- nesting and path in BMG correspond to nesting in XSD
- domains/format/masks in BMG match those in DAS
- heeftrelatiemet is same as actual relation from parsed conditions/tellingen.

To aggregate
- everthing in DAS
+ multiplicity
+ nesting (XSD/BMG)
+ allowed values (BMG)
*/  
  
public BMGTable loadBMGTable() = readCSV(#BMGTable, BMGCSV);

public Node bmgTable2Node(BMGTable tbl) {
  int level = 0;  
  list[Node] stack = [];
  
  void unwind(int levels) {
    for (int i <- [1..levels]) {
      <elt, stack> = pop(stack);
      link(elt);
    }
  }
  
  void link(Node tree) {
     <parent, stack> = pop(stack);
     parent.kids += [tree];
     stack = push(parent, stack);
  }
  
  void recordNode(Node tree, int newLevel) {
    if (newLevel == level) {
      unwind(1);
      stack = push(tree, stack);
    }
    else if (newLevel - level == 1) { // no support for bigger jumps
      stack = push(tree, stack);
    }
    else if (newLevel - level < 0) {
      unwind(level - newLevel + 1);
      stack = push(tree, stack);
    }
    else {
      println("Warning unhandled level change: <level> to <record.Nivo>");
    }
    level = newLevel;
  }
  
  void recordSubElement(BMGRecord record) {
    <elt, stack> = pop(stack);
    if (record.SubelCode != "") {
      elt.fields += [<record.SubelCode, record.SubelNaam>];
    }
    else if (record.DomwCode != "") {
      elt.values += [<record.DomwCode, record.DomwNaam>];
    }
    else {
      println("WARNING: unhandled field/domainvalue: <record>");
    }
    stack = push(elt, stack);
  }

  for (record <- tbl) {
    newLevel = record.Nivo;
    if (newLevel == 0) { 
      recordSubElement(record);
    }
    else if (record.Id != 0) {
      recordNode(section(record.Id, record.GgrNaam, record.AantHerh, []), newLevel);
    }  
    else { // leaf
      recordNode(element(record.GelId, record.GelNaam, record.Formaat, record.Masker,
                       record.ImplemAanw, record.Code, [], []), newLevel);      
    }
  }
  unwind(level - 1);  

  println(size(stack));
  return top(stack);
}

