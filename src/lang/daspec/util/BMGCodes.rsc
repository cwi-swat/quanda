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
alias MBMG =
  list[tuple[int Nivo, int AantHerh, int Id, str GgrNaam, int GelId, str GelNaam, str SubelCode, 
  str SubelNaam, str DomwCode, str DomwNaam, str Formaat, str Masker, str ImplemAanw, 
  str MidNaam, str Code, str a, str b, str c]];
  
  
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


data BMGTree = T(int key, str name, list[BMGTree] kids)
  | root(list[BMGTree] kids);

public BMGTree toTree(MBMG lst) {
  stack = [root([])];
  nivo = 0;
  for (record <- lst) {
    println("At level: <nivo> stack size: <size(stack)>");
    if (record.Nivo == 0 || record.Id == 0) {
      ;// value element
      continue;
    }
    tree = T(record.Id, record.GgrNaam, []);
    if (record.Nivo == nivo) {
      //println("pop in == nivo = <nivo> stack = <stack>");
      <parent, stack> = pop(stack);
      parent.kids += [tree];
      stack = push(parent, stack);
    }
    else if (record.Nivo - nivo == 1) { // no support for bigger jumps
      println("PUSH");
      nivo = record.Nivo;
      stack = push(tree, stack);
    }
    else if (record.Nivo - nivo < 0) {
      println("POP");
      unwinds = nivo - record.Nivo;
      for (i <- [1..unwinds]) {
        <parent, stack> = pop(stack);
        <pparent, stack> = pop(stack);
        pparent.kids += [parent];
        stack = push(pparent, stack);
      }
      //stack = push(tree, stack);
      println("pop");
      <parent, stack> = pop(stack);
      parent.kids += [tree];
      stack = push(parent, stack);
      nivo = record.Nivo;
    }
    else {
      println("Warning unhandled level change: <nivo> to <record.Nivo>");
    }
  }
  
  for (i <- [1..nivo]) {
    println("popping <i>");
    <parent, stack> = pop(stack);
    <pparent, stack> = pop(stack);
    pparent.kids += [parent];
    stack = push(pparent, stack);
  }
  
  //iprintln(stack);
  println(size(stack));
  return top(stack);
  //return root([]);
}

