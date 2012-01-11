module lang::daspec::gui::ValidateFormat

import lang::daspec::model::Datum;
import lang::daspec::model::Domains;
import String;
import List;

private set[str] NUMERIC_PLACEHOLDERS = {"#", "E", "J", "M", "D", "n"};

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

public bool validateMaskAndRanges(Format form, [], [], str s) = true;
public bool validateMaskAndRanges(Format form, ms:[_, *_], [], str s) = validateMask(ms, s);
public bool validateMaskAndRanges(Format form, [], rs:[_, *_], str s) = validateRanges(form, [], rs, s);
public bool validateMaskAndRanges(Format form, ms:[_, *_], rs:[_, *_], str s) = 
   validateMask(ms, s) && validatRanges(form, ms, rs, s);

public bool validateRanges(Format form, list[str] ms, list[Range] ranges, str s) {
  return true;
}


public list[str] splitAccordingToMask(list[str] mask, str s) {
  
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

