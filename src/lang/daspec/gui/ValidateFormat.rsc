module lang::daspec::gui::ValidateFormat

import lang::daspec::model::Datum;
import lang::daspec::model::Expr;
import lang::daspec::model::Domains;
import lang::daspec::gui::Convert;
import String;
import List;

private set[str] NUMERIC_PLACEHOLDERS = {"#", "E", "J", "M", "D", "n"};
private set[str] LITERAL_PLACEHOLDERS = {".", "+"};

public bool(str) formatValidator(Format format) {
  return bool(str x) {
    return validateFormat(format, x);
  };
}

public bool validateDomain(Domains doms, str dom, str s) {
  if (decl(dom, form, ms, rs) <- doms.decls) {
    if (!validateFormat(form, s)) {
      return false;
    }
    return validateMaskAndRanges(form, ms, rs, s);
  }
  throw "No such domain: <dom>";
}


public test bool validMR1() = validateMaskAndRanges(["a", "a", "a"], [enum([sym("abc"), sym("def")])], "abc");
public test bool validMR2() = !validateMaskAndRanges(["a", "a", "a"], [enum([sym("abc"), sym("def")])], "adc");
public test bool validMR3() = validateMaskAndRanges(["a", "a", "a"], [enum([sym("abc"), sym("def")])], "def");
public test bool validMR4() = validateMaskAndRanges([], [enum([sym("abc"), sym("def")])], "def");
public test bool validMR5() = !validateMaskAndRanges(["a", "+", "n", "n"], [enum([sym("a"), sym("b")]), range(0, 10)], "def");
public test bool validMR6() = !validateMaskAndRanges(["a", "+", "n", "n"], [enum([sym("a"), sym("b")]), range(0, 10)], "x+10");
public test bool validMR7() = validateMaskAndRanges(["a", "+", "n", "n"], [enum([sym("a"), sym("b")]), range(0, 10)], "a+10");
public test bool validMR8() = validateMaskAndRanges(["a", "+", "n", "n"], [enum([sym("a"), sym("b")]), range(0, 10)], "b+10");
public test bool validMR9() = !validateMaskAndRanges(["a", "+", "n", "n"], [enum([sym("a"), sym("b")]), range(0, 10)], "b+11");

public bool validateMaskAndRanges([], [], str s) = true;
  
public bool validateMaskAndRanges(list[str] ms, [], str s) = validateMask(ms, s)
  when ms != [];

public bool validateMaskAndRanges([], list[Range] rs, str s) = validateRanges([], rs, s)
  when rs != [];

public default bool validateMaskAndRanges(list[str] ms, list[Range] rs, str s) = 
   validateMask(ms, s) && validateRanges(ms, rs, s);


public bool validateRanges(list[str] _, [], str s) = true;

public bool validateRanges(list[str] _, [r], str s) = checkRange(r, s);

public default bool validateRanges(list[str] ms, list[Range] rs, str s) {
  elts = splitAccordingToMask(ms, s);
  if (size(elts) != size(rs)) {
    return false;
  }
  return ( true | it && checkRange(rs[i], elts[i]) | i <- [0..size(elts) - 1] );
}

public bool checkRange(enum(vs), str s) = ( false | it || checkValue(v, s) | v <- vs );
public bool checkRange(range(int a, int b), str s) = a <= toInt(s) && toInt(s) <= b;
public bool checkRange(range(real a, real b), str s) = a <= toReal(s) && toReal(s) <= b;

public bool checkValue(nat(n), str s) = toInt(s) == n;
public bool checkValue(sym(x), str s) = x == s;


public list[str] splitAccordingToMask(list[str] mask, str s) {
  // assumes that s conforms to mask
  i = 0;
  last = 0;
  elts = for (m <- mask) {
    if (m in LITERAL_PLACEHOLDERS) {
      append substring(s, last, i);
      last = i + 1;
    }
    i += 1;
  }
  elts += [substring(s, last, i)];
  return elts;
}

public bool validateMask(list[str] tokens, str s) {
  if (size(s) != size(tokens)) {
    return false;
  }
  return (true | it && matchToken(tokens[i], s[i]) | i <- [0..size(s) - 1] );
}

public bool matchToken(str token, str char) = /^[0-9]$/ := char
  when token in NUMERIC_PLACEHOLDERS;
  
public bool matchToken("a", str char) = /^[a-zA-Z]$/ := char;
  
public default bool matchToken(str token, str char) = token == char;

public bool validateFormat(alpha(n), str s) = /^[a-zA-Z]{<n>}$/ := s;
public bool validateFormat(alphaNumeric(n), str s) = /^[a-zA-Z0-9]{<n>}$/ := s;
public bool validateFormat(alphaNumericUpTo(n), str s) = /^[a-zA-Z0-9]{0,<n>}$/ := s;
public bool validateFormat(numeric(n), str s) = /^[0-9]{<n>}$/ := s;
public bool validateFormat(numericUpTo(n), str s) = /^[0-9]{0,<n>}$/ := s;

public bool validateFormat(integer(n), str s) =  /^[0-9]{<n>}$/ := s || /^-[0-9]{<m>}$/ := s
  when int m := n - 1;

public bool validateFormat(integerUpTo(n), str s) =  /^[0-9]{0,<n>}$/ := s || /^-[0-9]{0,<m>}$/ := s
  when int m := n - 1;

