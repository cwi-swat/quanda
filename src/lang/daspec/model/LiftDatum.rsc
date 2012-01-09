module lang::daspec::model::LiftDatum

import lang::daspec::model::Datum;
import lang::daspec::syntax::Expr;
import lang::daspec::util::Parse;
import lang::daspec::util::Implode;

import lang::xml::DOM;
import ParseTree;

// to deal with unparseable expressions
data Exp = parseError(Tree errorTree);

private loc DA2011_XML_FILE = |file:///Users/tvdstorm/CWI/quanda/cases/specs/da2011/da20110929.xml|; 

public Node DA2011XML() = readXMLDOM(DA2011_XML_FILE);

public map[str, str] attributeMap(Node elt) 
  = ( n: v | attribute(_, n, v) <- elt.children );

public Datum liftDatum(Node n) {
  attrs = attributeMap(n);
  conds = { <nm, e> | /element(_, "condition", [attribute(_, "name", nm), charData(e)]) <- n  };
  exps = { <nm, e> | /element(_, "expression", [attribute(_, "name", nm), charData(e)]) <- n };
  eval = [ e | /element(_, "compute_as", [charData(e)]) <- n ];
  
  labels = ["source", "explanation", "definition"];
  docs = ( tg: x | element(_, tg, [charData(x)]) <- n.children, tg in labels );
  docs += ( tg: "" | element(_, tg, []) <- n.children, tg in labels );

  str typ;
  if (attrs["domain"] != "") {
    typ = domain(attrs["domain"]);
  }
  else {
    typ = implodeFormat(parseFormat(attrs["format"]));
  }

  sects = [
    usedBy([ toInt(k) | k <- split(",", attrs["relates_to"]) ]),
    page(toInt(attrs["page"])),
    definition(docs["definition"])
  ];
  
  if (trim(docs["explanation"]) != "") {
    sects += [explanation(docs["explanation"])];
  }
  if (trim(docs["source"]) != "") {
    sects += [explanation(docs["source"])];
  }
  
  Exp pExp(str src) {
    Tree t = parseExpWithErrorTree(src);
    return t is error ? parseError(t) : implodeExp(t);
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
  return datum(attrs["name"], attrs["id"], typ, sects);
}

