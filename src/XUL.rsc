module XUL

import XMLDOM;
import List;
import String;
import Set;

public Node xulSchema() {
  return readXMLDOM(|project://quanda/xul/xulplanet.xsd|);
}

public set[str] xulElements(Node xs) {
  return { e | /element(namespace("xs", _), "element", kids) <- xs, attribute(_, "name", e) <- kids };
}

public set[str] xulAttributes(Node xs) {
  return { a | /element(namespace("xs", _), "attribute", kids) <- xs, attribute(_, "name", a) <- kids };
}


public map[str, str] xulTypedAttributes(Node xs) {
  return ( a: t | /element(namespace("xs", _), "attribute", kids) <- xs, 
  				attribute(_, "name", a) <- kids,
  				attribute(_, "type", /^.*:<t:.*>$/) <- kids );
}

public map[str, set[str]] xulEnums(Node xs) {
  return ( a: es | /element(namespace("xs", _), "attribute", kids) <- xs, 
  		attribute(_, "name", a) <- kids,
  		set[str] es := { v | /element(_, "enumeration", [attribute(_, "value", v)]) <- kids }, es != {} );
}

public str capitalize(str s) {
  return toUpperCase(substring(s, 0, 1)) + substring(s, 1);
}


public str xulDOM() {
  xs = readXMLDOM(|project://quanda/xul/xulplanet.xsd|);
  elts = xulElements(xs);
  attrs = xulAttributes(xs);
  tattrs = xulTypedAttributes(xs);
  eattrs = xulEnums(xs);
  tattrs += ( a: "string" | a <- attrs, a notin tattrs, a notin eattrs );
  tattrs += ( a: capitalize(a) | a <- eattrs, a notin tattrs );
  
  
  cons = [ "<e>(set[XULAttr] attrs, list[XULNode] kids)", "<e>(list[XULNode] kids)" | e <- elts ];
  
  tmap = ("int": "int", "string": "str", "scriptType": "str", "boolType": "bool"); 
  acons = [ "<a>(<tmap[tattrs[a]] ? tattrs[a]> val)" | a <- tattrs ];
  
  
  nodes = "data XULNode\n  = <intercalate("\n  | ", sort(cons))>;";
  attrs = "data XULAttr\n  = <intercalate("\n  | ", sort(acons))>;";

  edata = [ "data <capitalize(e)> = <intercalate(" | ", [ "<x>()" | x <- eattrs[e] ])>;\n" | e <- eattrs ];
   
  
  return "module XULDOM
         '
         '<nodes>
         '
         '<attrs>
         '
         '<intercalate("\n", edata)>
         '";
}