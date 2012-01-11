module lang::daspec::gui::Convert

import String;

public value convert(numeric(n), str s) = toInt(s);
public value convert(numericUpTo(n), str s) = toInt(s);
public default value convert(_, str s) = s;


