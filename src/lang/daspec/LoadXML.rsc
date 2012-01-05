module lang::daspec::LoadXML

import XMLDOM;
import IO;
import List;
import String;

private loc DA2011_XML_FILE = |file:///Users/tvdstorm/CWI/quanda/cases/specs/da2011/da20110929.xml|; 

public Node DA2011XML() = readXMLDOM(DA2011_XML_FILE);

public void dumpDatums(Node doc) {
  root = doc.root;
  for (e:element(_, n, kids) <- root.children) {
    <id, src> = datum2source(e);
    writeFile(|project://quanda/input/<id>.das|, src);
  }
}

public tuple[str, str] datum2source(Node n) {
  attrs = ( name: x | attribute(_, name, x) <- n.children );
  conds = [ d | e:element(_, "conditions", kids) <- n.children, element(_, "condition", [charData(d)]) <- e.children ];
  
  eval = ( tg : e | element(_, tg, [charData(e)]) <- n.children, tg in ["countings", "compute_as"] );
  
  labels = ["source", "explanation", "definition"];
  docs = ( tg: x | element(_, tg, [charData(x)]) <- n.children, tg in labels );
  docs += ( tg: "" | element(_, tg, []) <- n.children, tg in labels );
  //return "<attrs> <conds> <docs>";
  typ = attrs["format"];
  if (attrs["domain"] != "") {
    typ = attrs["domain"];
  }
  return <attrs["id"], "gegeven <attrs["name"]> [<attrs["id"]>]: <typ> {
         '  <if (attrs["relates_to"] != "") {>
         '  gebruikt in <attrs["relates_to"]>
         '  <}>
         '
         '  definitie {<docs["definition"]>
         '  }
         '  <if (trim(docs["explanation"]) != "") {>
         '  toelichting {<docs["explanation"]>
         '  }
         '  <}>
         '  <if (trim(docs["source"]) != "") {>
         '  bron {<docs["source"]>
         '  }
         '  <}>
         '  <for (c <- conds) {>
         '  conditie <c>
         '  <}>
         '  <if (trim(eval["countings"]) != "") {>
         '  bereken als <eval["countings"]>
         '  <}>
         '  <if (trim(eval["compute_as"]) != "") {>
         '  bereken als {<eval["compute_as"]>
         '  }
         '  <}>
         '}">;
}