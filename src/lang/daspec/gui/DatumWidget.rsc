module lang::daspec::gui::DatumWidget

import lang::daspec::gui::State;

import vis::Figure;
import IO;

public void(str) updater(int key) = (str txt) { update(key, txt); };


public Figure datumWidget(str label, str txt, bool(str) validate, void(str) update) {
  return hcat([text(label), textfield(txt, update, validate)]);
}