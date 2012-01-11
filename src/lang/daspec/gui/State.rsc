module lang::daspec::gui::State

public alias State = map[int, str];

private State STATE = ();

public void update(int key, str txt) {
  STATE[key] = txt;
}

public str lookup(int key) = STATE[key];
