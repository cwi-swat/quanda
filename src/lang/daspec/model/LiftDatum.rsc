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
import IO;

 
private loc DA2011_XML_FILE = |file:///Users/tvdstorm/CWI/quanda/cases/specs/da2011/da20110929.xml|; 
public loc DA2011_MAPPING_XSD_FILE = |file:///Users/tvdstorm/CWI/quanda/cases/specs/da2011/1.3/da20110503-mapping.xsd|; 

public Node DA2011XML() = readXMLDOM(DA2011_XML_FILE);

data TagInfo 
  = tagInfo(str name, int lowerBound, int upperBound);
 
alias BMG = int;

public map[BMG, TagInfo] bmg2tagMapping() {
  doc = readXMLDOM(DA2011_MAPPING_XSD_FILE);
  m = ();
  visit (doc) {
    case element(_, "element", ks): {
      if (attribute(_, "name", str n) <- ks,  attribute(_, "id", str i) <- ks) {
        bmg = toInt(i);
        if (m[bmg]?) {
          println("WARNING: duplicate bmg: <bmg> for <m[bmg]> and <n>");
        }
        int min = 1;
        int max = 1;
        if (attribute(_, "minOccurs", str x) <- ks) {
           min = toInt(x);
        }
        if (attribute(_, "maxOccurs", str x) <- ks) {
           max = toInt(x);
        }
        m[bmg] = tagInfo(n, min, max);
      }
    }
  }
  return m;
}

public str formatDatum(Datum d) = format(datum2box(d));

public void dumpDatum(Datum d) {
  // todo cannot interpolate ints in locs
  s = "<d.key.key>";
  l = |project://quanda/input/<s>.das|;
  println("Dumping to: <l>");
  writeFile(l, formatDatum(d));
}

public void dumpDatums() {
  doc = DA2011XML();
  root = doc.root;
  bmg = bmg2tagMapping();
  for (e:element(_, n, kids) <- root.children) {
    try {
      dumpDatum(liftDatum(e, bmg));
    }
    catch IllegalArgument(Tree t, str msg): {
      println("AMB: <msg>: <unparse(t)>");
    }  
  }
}

public Datum liftDatum(int key) {
  doc = DA2011XML();
  root = doc.root;
  bmg = bmg2tagMapping();
  for (e:element(_, n, kids) <- root.children) {
    attrs = attributeMap(e);
    if (attrs["id"] == "<key>") {
      return liftDatum(e, bmg);
    }
  }
  throw "Could not find datum with id: <key>";
}

public Datum liftDatum(Node n, map[BMG, TagInfo] bmg) {
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
    typ = format(implodeFormat(parseFormat(attrs["format"])));
  }

  k = toInt(attrs["id"]);
  
  sects = [];
  if (bmg[k]?) {
	  sects = [
	    shorthand(bmg[k].name),
	    lowerBound(bmg[k].lowerBound),
	    upperBound(bmg[k].upperBound)
	  ];
  }
  else {
    println("WARNING: no tagname for bmg <k>");
  }
  
  sects += [
    usedBy([ key(toInt(trim(k))) | str k <- split(",", attrs["relates_to"]), k != "" ]),
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
    //norm = squeeze(replaceAll(trim(src), "\n", " "), " ");
    src = trim(src);
    try
      // parse with error tree does not work
      //Tree t = parseExpWithErrorTree(trim(src));
      return implodeExp(parseExp(src));
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
  
  return datum(attrs["name"], key(k), typ, sects);
}


public map[str, str] attributeMap(Node elt) 
  = ( n: v | attribute(_, n, v) <- elt.children );

