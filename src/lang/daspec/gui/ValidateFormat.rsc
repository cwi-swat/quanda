module lang::daspec::gui::ValidateFormat

import lang::daspec::model::Datum;

public bool(str) formatValidator(Format format) {
  return bool(str x) {
    return validateFormat(format, x);
  };
}

public bool validateFormat(alpha(n), str s) = /^[a-zA-Z]{<n>}$/ := s;
public bool validateFormat(alphaNumeric(n), str s) = /^[a-zA-Z0-9]{<n>}$/ := s;
public bool validateFormat(alphaNumericUpTo(n), str s) = /^[a-zA-Z0-9]{0,<n>}$/ := s;
public bool validateFormat(numeric(n), str s) = /^[0-9]{<n>}$/ := s;
public bool validateFormat(numericUpTo(n), str s) = /^[0-9]{0,<n>}$/ := s;

