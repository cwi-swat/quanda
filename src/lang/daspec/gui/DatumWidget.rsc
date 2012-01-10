module lang::daspec::gui::DatumWidget

import vis::Figure;
import IO;

public bool isEmail(str s) {
  println("Validating: <s>");
  return /[a-z.]+@[a-z.]+/ := s;
}

public Figure datumWidget(str label, bool(str) validate) {
  void entered(str s) { 
    println(s);
  }
  return hcat([text(label), textfield("", entered, validate)]);
}