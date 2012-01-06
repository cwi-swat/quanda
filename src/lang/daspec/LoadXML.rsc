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
  conds = { <nm, e> | /element(_, "condition", [attribute(_, "name", nm), charData(e)]) <- n  };
  exps = { <nm, e> | /element(_, "expression", [attribute(_, "name", nm), charData(e)]) <- n };
  eval = [ e | /element(_, "compute_as", [charData(e)]) <- n ];
  
  labels = ["source", "explanation", "definition"];
  docs = ( tg: x | element(_, tg, [charData(x)]) <- n.children, tg in labels );
  docs += ( tg: "" | element(_, tg, []) <- n.children, tg in labels );

  typ = attrs["format"];
  if (attrs["domain"] != "") {
    typ = attrs["domain"];
  }
  return <attrs["id"], "gegeven <attrs["name"]> [<attrs["id"]>]: <typ> {
         '  <if (attrs["relates_to"] != "") {>
         '  gebruikt in <attrs["relates_to"]>
         '  <}>
         '  pagina <attrs["page"]>
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
         '  <for (<nm, ce> <- conds, nm != "") {>
         '  conditie <nm>: <ce>
         '  <}>
         '  <for (<nm, ce> <- conds, nm == "") {>
         '  conditie <ce>
         '  <}>
         '  <for (<nm, ee> <- exps, nm != "") {>
         '  bereken <nm>: <ee>
         '  <}>
         '  <for (<nm, ee> <- exps, nm == "") {>
         '  bereken <ee>
         '  <}>
         '  <for (ev <- eval, trim(ev) != "") {>
         '  bereken  {<ev>
         '  }
         '  <}>
         '}">;
}