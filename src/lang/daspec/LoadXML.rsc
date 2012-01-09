module lang::daspec::LoadXML

import lang::xml::DOM;
import IO;
import List;
import String;
import util::Math;

import lang::daspec::model::TOC;
import lang::daspec::format::TOC2Box;
import lang::daspec::model::Datum;

private loc DA2011_XML_FILE = |file:///Users/tvdstorm/CWI/quanda/cases/specs/da2011/da20110929.xml|; 
private loc DA2011_TOC_XML_FILE = |file:///Users/tvdstorm/CWI/quanda/cases/specs/da2011/da20110929-toc.xml|; 

public Node DA2011XML() = readXMLDOM(DA2011_XML_FILE);

public TOC liftTOC() {
  doc = readXMLDOM(DA2011_TOC_XML_FILE);
  toc = liftTOC(doc.root);
  ind = indexDatums(DA2011XML());
  toc = insertDatums(toc, ind);
  return toc;
}

public void dumpTOC() {
  toc = liftTOC();
  writeFile(|project://quanda/input/_da2011.toc|, formatTOC(toc));
}


public map[str, str] attributeMap(Node elt) 
  = ( n: v | attribute(_, n, v) <- elt.children );

public TOC liftTOC(element(_, "toc", elts)) = 
  toc([ liftEntry(e) | e:element(_,_,_) <- elts ]);

public Entry liftEntry(e:element(_, "entry", kids)) {
  m = attributeMap(e); 
  return section(m["title"],
     // use e instead of k and it does not match. 
     [ liftEntry(k) | k:element(_, _, _) <- kids ],
     toInt(m["page"]));
}

public default Entry liftEntry(Node n) {
  throw "Error <n>";
} 

// approximation
public TOC insertDatums(TOC toc, map[str, list[NameId]] datums) {
  last_page = ( -1 | p > it ? p : it | /section(_, _, p) := toc );
  order = [ "" | _ <- [1..last_page] ];
  visit (toc) {
    case section(t, _, p): order[p - 1] = t;
  }
  m = ();
  for (p <- datums) {
    no = toInt(p);
    // not good: for two consecutive same page nos it's not clear if you
    // need the last or the first. So, it's not possible to be exact. :-(
    //sect = ("" | order[i] | i <- [0..last_page - 1], i < no, order[i] != "" );
    sect =  "";
    if (i <- [no-1,no-2..0], order[i] != "")
      sect = order[i];
    if (sect notin m) {
      m[sect] = [];
    }
    m[sect] += datums[p];  
  }
  return visit (toc) {
    case section(t, es, p) => 
       section(t, [ datum(n, toInt(i)) | <n, i> <- m[t] ] + es , p)
        when t in m 
  }
}

public void dumpDatums(Node doc) {
  root = doc.root;
  for (e:element(_, n, kids) <- root.children) {
    <id, src> = datum2source(e);
    writeFile(|project://quanda/input/<id>.das|, src);
  }
}

alias NameId = tuple[str name, str id];

public map[str, list[NameId]] indexDatums(Node doc) {
  root = doc.root;
  index = ();
  list[NameId] EMPTY = [];
  for (e:element(_, n, kids) <- root.children) {
    attrs = ( name: x | attribute(_, name, x) <- kids );
    index[attrs["page"]]?EMPTY += [<attrs["name"], attrs["id"]>];
  }
  return index;
}

public Datum liftDatum(Node n) {
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