module lang::daspec::load::FromXML

import lang::daspec::model::Spec;
import lang::daspec::util::Parse;
import lang::daspec::util::Implode;
import lang::xml::DOM;
import IO;
import String;
import List;
import Exception;
import ParseTree;
import Ambiguity;

public loc DA2012 = |project://quanda/cases/specs/ibvpb2012-nt7.0/2%20Gegevensspecificaties/GegevensSpecificatie_da2012_v3.0_20120620_inxml-vorm.xml|;

public Node loadSpecFromXML(loc file) = parseXMLDOM(readFile(file));

private Namespace NS = none();

public Spec loadSpec(loc file) {
  n = loadSpecFromXML(file);
  s = spec("", "", []);
  top-down visit (n) {
    case element(NS, "BerichtReferentieModel", 
           [attribute(NS, "type", str t), attribute(NS, "versie", str v), *_]): {
      s.\type = t;
      s.version = v;
    }
    case e:element(NS, "Groep", _):
      s.datums += [node2datum(e)];
  }
  return s;
}

public Datum node2datum(Node n) {
  switch (n) {
    case element(NS, "Groep", [attribute(NS, "naam", name), *kids]):
      return group(name, [node2datum(k) | k:element(_, _, _) <- kids]);
    case element(NS, "Element", [attribute(NS, "naam", str name), *kids]): {
      Type t = domain("UNKNOWN");
      int k = -1;
      visit (kids) {
       case element(NS, "Formaat", [charData(str f)]):
         t = format(implodeFormat(parseFormat(f)));
       case element(NS, "Domein", [attribute(NS, "naam", str n)]):
         t = domain(n);
       case element(NS, "Identificatienummer", [charData(str nr)]):
         k = toInt(nr);
      }
      //println("Lifting <name> (<k>)");
      Datum d = datum(name, key(k), t, []);
      top-down visit (kids) {
        case element(NS, "Definitie", [charData(str txt)]): 
          d.body += [definition(txt)];
        case element(NS, "Heeftrelatiemet", [charData(str txt)]):
          d.body += [usedBy([ key(toInt(k)) | str k <- split(", ", txt)  ])];
        case element(NS, "Toelichting", [charData(str txt)]):
          d.body += [explanation(txt)];
        case element(NS, "Bron", [charData(str txt)]):
          d.body += [source(txt)];
        case element(NS, "Tellingen", [cdata(str txt)]):
          d.body += [formula([], makeExp(txt))];
        case element(NS, "Tellingen", [attribute(NS, "naam", str n), cdata(str txt)]):
          d.body += [formula([n], makeExp(txt))];
        case element(NS, "Condities", [cdata(str txt)]):
          d.body += [condition([], makeExp(txt))];
        case element(NS, "Condities", [attribute(NS, "naam", str n), cdata(str txt)]):
          d.body += [condition([n], makeExp(txt))];
      }
      return d;  
    }
    case Node n: {
      println("Unmatched node: ");
      iprintln(n);
      throw "Error";
    } 
  }
} 



Exp makeExp(str src) {
  set[str] stuff = {"IB)", "VPB)", "Vpb)", "IB:", "VPB:"};
  src = trim(src);
  // some cleanup:
  for (x <- stuff) {
    if (startsWith(src, x)) {
      src = substring(src, size(x));
      break;
    }
  }
  if (endsWith(src, ".")) {
    src = substring(src, 0, size(src) - 1);
  }
  try {
    // parse with error tree does not work
    //Tree t = parseExpWithErrorTree(trim(src));
    Tree pt = parseExp(src);
    msgs = diagnose(pt);
    if (msgs != []) {
      println("Ambiguity: <src>");
      for (m <- msgs) {
        println(m);
      }
      return parseError(src, pt@\loc);
    }
    t =  implodeExp(pt);
    //println("Success");
    return t;
  }
  catch ParseError(loc l): {
    println("Parse error: <src>");
    return parseError(src, l);
  }
}

  