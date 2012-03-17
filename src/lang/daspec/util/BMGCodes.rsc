module lang::daspec::util::BMGCodes

import lang::csv::IO;
import List;
import IO;

private loc BMGCSV = 
 |project://quanda/cases/specs/da2011/1.4/2%20Gegevensspecificaties/mBMG%20DA2011%20v2_1_20110701.csv|;
 

private loc DACSV = 
 |project://quanda/cases/specs/da2011/1.4/2%20Gegevensspecificaties/CSV%20-%20Gegevensspec%20da2011%20IH%20VPB%20v2.3%2020110929.csv|;

// NB: last Code is path into XML Schema from Berichtspecificatie.
// AantHerh: 1 required, 0 means optional, 99 means maximally 99

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
  str MidNaam, 
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
  
alias MBMG =
  list[BMGRecord];
  
alias DAS =
  list[tuple[str naam, int identificatienummer, str definitie, str toelichting, str formaat, 
  str condities, str domein, str heeftrelatiemet, str bron, str tellingen, str berekeningswijzes]];
  
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
  
  
public DAS das() {
  return readCSV(#DAS, DACSV);
}  
  
public MBMG bmgs() {
  return readCSV(#MBMG, BMGCSV);
}  

public Node toTree(MBMG lst) {
  stack = [];
  void unwind(int levels) {
    for (int i <- [1..levels]) {
      <elt, stack> = pop(stack);
      <parent, stack> = pop(stack);
      parent.kids += [elt];
      stack = push(parent, stack);
    }
  }
  
  void link(Node tree) {
     <x, stack> = pop(stack);
     if (parent:section(_, _, _, _) := x) { 
       parent.kids += [tree];
       stack = push(parent, stack);
     }
     else {
       println("Attempt to add child to node that is not a section: <x>");
       stack = push(x, stack);
     }
  }
  
  
  nivo = 0;
  
  for (record <- lst) {
    if (record.Nivo == 0) { // field or domain value
      // belongs to the last element added to the section that
      // is on the top of the stack.
      <parent, stack> = pop(stack);
      elt = last(parent.kids);
      if (record.SubelCode != "") {
        elt.fields += [<record.SubelCode, record.SubelNaam>];
      }
      else if (record.DomwCode != "") {
        elt.values += [<record.DomwCode, record.DomwNaam>];
      }
      else {
        println("WARNING: unhandled field/domainvalue: <record>");
      }
      parent.kids = [*prefix(parent.kids), elt];
      stack = push(parent, stack);
      continue;
    }
    if (record.Id != 0) { // section
      tree = section(record.Id, record.GgrNaam, record.AantHerh, []);
      if (record.Nivo == nivo) {
        link(tree);
      }
      else if (record.Nivo - nivo == 1) { // no support for bigger jumps
        stack = push(tree, stack);
      }
      else if (record.Nivo - nivo < 0) {
        unwind(nivo - record.Nivo);
        link(tree);
      }
      else {
        println("Warning unhandled level change: <nivo> to <record.Nivo>");
      }
      // only update level here, since leaf elements
      // are not on the stack.
      nivo = record.Nivo;
    }  
    else { // leaf
      tree = element(record.GelId, record.GelNaam, record.Formaat, record.Masker,
                       record.ImplemAanw, record.Code, [], []);
      link(tree);      
    }
        
  }
  unwind(nivo - 1);  
  return top(stack);
}

