module lang::daspec::gui::State


private map[int, str] STATE = ();

public void update(int key, str txt) {
  STATE[key] = txt;
}

public str lookup(int key) = STATE[key];
