module lang::daspec::util::BMGCodes

import lang::csv::IO;

private loc BMGCSV = 
 |project://quanda/cases/specs/da2011/1.4/2%20Gegevensspecificaties/mBMG%20DA2011%20v2_1_20110701.csv|;
 

private loc DACSV = 
 |project://quanda/cases/specs/da2011/1.4/2%20Gegevensspecificaties/CSV%20-%20Gegevensspec%20da2011%20IH%20VPB%20v2.3%2020110929.csv|;

// NB: last Code is path into XML Schema from Berichtspecificatie.

alias MBMG =
  list[tuple[int Nivo, int AantHerh, int Id, str GgrNaam, int GelId, str GelNaam, str SubelCode, 
  str SubelNaam, str DomwCode, str DomwNaam, str Formaat, str Masker, str ImplemAanw, 
  str MidNaam, str Code, str a, str b, str c]];
  
  
alias DAS =
  list[tuple[str naam, int identificatienummer, str definitie, str toelichting, str formaat, 
  str condities, str domein, str heeftrelatiemet, str bron, str tellingen, str berekeningswijzes]];
  
public DAS das() {
  return readCSV(#DAS, DACSV);
}  
  
public MBMG bmgs() {
  return readCSV(#MBMG, BMGCSV);
}  