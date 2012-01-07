module lang::daspec::model::TOC

data TOC = toc(list[Entry] entries);

data Entry
  = datum(str name, int key)
  | section(str title, list[Entry] entries)
  | section(str title, list[Entry] entries, int page)
  ;

  
