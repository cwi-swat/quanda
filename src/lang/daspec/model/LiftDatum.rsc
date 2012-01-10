module lang::daspec::model::LiftDatum

import lang::daspec::model::Datum;
import lang::daspec::model::Expr;
import lang::daspec::util::Parse;
import lang::daspec::util::Implode;
import lang::daspec::format::Datum2Box;

import lang::box::util::Box2Text;

import lang::xml::DOM;
import ParseTree;
import String;

 
private loc DA2011_XML_FILE = |file:///Users/tvdstorm/CWI/quanda/cases/specs/da2011/da20110929.xml|; 

public Node DA2011XML() = readXMLDOM(DA2011_XML_FILE);

public str formatDatum(Datum d) = format(datum2box(d));

public Datum liftDatum(int key) {
  doc = DA2011XML();
  root = doc.root;
  for (e:element(_, n, kids) <- root.children) {
    attrs = attributeMap(e);
    if (attrs["id"] == "<key>") {
      return liftDatum(e);
    }
  }
  throw "Could not find datum with id: <key>";
}

public Datum liftDatum(Node n) {
  attrs = attributeMap(n);
  conds = { <nm, e> | /element(_, "condition", [attribute(_, "name", nm), charData(e)]) <- n  };
  exps = { <nm, e> | /element(_, "expression", [attribute(_, "name", nm), charData(e)]) <- n };
  eval = [ e | /element(_, "compute_as", [charData(e)]) <- n ];
  
  labels = ["source", "explanation", "definition"];
  docs = ( tg: x | element(_, tg, [charData(x)]) <- n.children, tg in labels );
  docs += ( tg: "" | element(_, tg, []) <- n.children, tg in labels );

  docs = ( k: squeeze(replaceAll(trim(docs[k]), "\n", " "), " ") | k <- docs ); 

  str typ;
  if (attrs["domain"] != "") {
    typ = domain(attrs["domain"]);
  }
  else {
    typ = implodeFormat(parseFormat(attrs["format"]));
  }

  sects = [
    usedBy([ toInt(trim(k)) | k <- split(",", attrs["relates_to"]), k != "" ]),
    page(toInt(attrs["page"])),
    definition(docs["definition"])
  ];
  
  if (trim(docs["explanation"]) != "") {
    sects += [explanation(docs["explanation"])];
  }
  if (trim(docs["source"]) != "") {
    sects += [source(docs["source"])];
  }
  
  Exp pExp(str src) {
    norm = squeeze(replaceAll(trim(src), "\n", " "), " ");
    try
      // parse with error tree does not work
      //Tree t = parseExpWithErrorTree(trim(src));
      return implodeExp(parseExp(norm));
    catch ParseError(loc l):
      return parseError(src, l);
  }
  
  sects += for (<nm, ce> <- conds) {
    append condition(nm != "" ? [nm] : [], pExp(ce));
  }

  sects += for (<nm, ce> <- exps, nm != "") {
    append formula(nm != "" ? [nm] : [], pExp(ce));
  }

  sects += for (ev <- eval, trim(ev) != "") {
    append algorithm(ev);
  }
  return datum(attrs["name"], toInt(attrs["id"]), typ, sects);
}


public map[str, str] attributeMap(Node elt) 
  = ( n: v | attribute(_, n, v) <- elt.children );

