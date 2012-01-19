module lang::daspec::export::Site

import lang::daspec::model::Datum;
import lang::daspec::model::Expr;
import lang::daspec::util::Parse;
import lang::daspec::util::Implode;

import lang::box::util::Highlight;
import lang::box::util::HighlightToHTML;

import lang::xml::DOM;
import lang::daspec::format::Datum2Box;
import lang::daspec::format::Expr2Box;
import lang::box::util::Box2Text;

import ParseTree;

import String;
import IO;

public loc OUTPUT_ROOT = |file:///Users/tvdstorm/CWI/quanda/output/site/|;
public loc INPUT_ROOT = |project://quanda/input|;

public void dumpSite() {
  fs = listEntries(INPUT_ROOT);
  for (f <- fs, /^<base:.*>\.das$/ := f) {
    inp = INPUT_ROOT + f;
    out = OUTPUT_ROOT + "<base>.html";
    println("Converting <inp.file> to <out.file>...");
    try {
      if (!exists(out)) {
        datum2html(inp, out);
      }
      else {
        println("HTML file <out> exists; skipped.");
      }
    }
    catch value x: {
      println("WARNING: exception for <f>: <x>");
    } 
  }
}

public void datum2html(loc input, loc output) {
  ast = implodeDatum(parseDatum(input));
  writeXMLRaw(output, datum2html(ast));
}

public str formatExp(Exp e) = format(expr2box(e));
public str formatType(Type t) = format(datum2box(t));

public str key2page(Key k) = "<k.key>.html";

private Namespace HTML = none();

public Node html(Node nodes...) = element(HTML, "html", nodes);
public Node head(Node nodes...) = element(HTML, "head", nodes); 
public Node title(str txt) = element(HTML, "title", [charData(txt)]); 
public Node body(Node nodes...) = element(HTML, "body", nodes);
public Node h1(str txt) = element(HTML, "h1", [charData(txt)]);
public Node h2(str txt) = element(HTML, "h2", [charData(txt)]);
public Node h3(str txt) = element(HTML, "h3", [charData(txt)]);
public Node h4(str txt) = element(HTML, "h4", [charData(txt)]);
public Node table(Node rows...) = element(HTML, "table", rows);
public Node thead(Node rows...) = element(HTML, "thead", rows);
public Node tr(Node nodes...) = element(HTML, "tr", nodes);
public Node td(Node nodes...) = element(HTML, "td", nodes);
public Node td(str txt) = element(HTML, "td", [charData(txt)]);
public Node th(Node nodes...) = element(HTML, "th", nodes);
public Node p(Node nodes...) = element(HTML, "p", nodes);
public Node p(str txt) = element(HTML, "p", [charData(escape(txt))]);
public Node em(Node nodes...) = element(HTML, "em", nodes);
public Node code(Node nodes...) = element(HTML, "code", nodes);
public Node a(str href, Node nodes...) = element(HTML, "a", [attribute("href", href), *nodes]);
public Node a(str href, str txt) = element(HTML, "a", [attribute("href", href), charData(txt)]);
public Node span(str class, Node nodes...) = element(HTML, "span", [attribute("class", class), *nodes]);
public Node nbsp() = entityRef("nbsp");
public Node link(str \rel, str \type, str href) = 
  element(HTML, "link", [attribute("rel", \rel), attribute("type", \type),
    attribute("href", href)]);
//<link rel="stylesheet" type="text/css" href="theme.css" />

public Node datum2html(datum(n, k, t, ss)) =
html(
  head(title("Gegeven: <n> [<k.key>]: <formatType(t)>"),
    link("stylesheet", "text/css", "site.css")),
  body(
    h1(n),
    table(
      [thead(th(), th())]
      +
      [ datum2html(s) | s <- ss ]
    )
  )
);

public Node datum2html(page(no)) = tr(td("Pagina"), td(), td(p("<no>")));

public Node datum2html(definition(txt)) = tr(td("Definitie"), td(), td(p(txt)));
 
public Node datum2html(explanation(txt)) = tr(td("Toelichting"), td(), td(p(txt)));
 
public Node datum2html(algorithm(txt)) = tr(td("Berekeningswijze"), td(), td(p(txt)));
 
public Node datum2html(source(txt)) = tr(td("Bron"), td(), td(p(txt)));
 
public Node datum2html(usedBy(ks)) = tr(td("Gebruikt in"), td(), 
  td(( [] | it + [a(key2page(k), "<k.key>"), charData(" ")] | k <- ks )));
 
public Node datum2html(condition([l], e)) = tr(td("Conditie"), td(l), 
      td(expr2html(e)));

public Node datum2html(condition([], e)) = tr(td("Conditie"), td(), 
      td(expr2html(e)));
 
public Node datum2html(formula([l], e)) = tr(td("Telling"), td(l), 
      td(expr2html(e)));

public Node datum2html(formula([], e)) = tr(td("Telling"), td(), 
      td(expr2html(e)));
      
public Node expr2html(Exp e) {
  pt = parseExp(trim(formatExp(e)));
  pt = visit (pt) {
    case Tree t: {
      if (t is key) {
        insert t[@link=|file:///<"<t>">.html|];
      }
      else {
        fail;
      }
    } 
  }


  return parseXMLDOM(highlight2code(highlight(pt))).root;
} 


  
