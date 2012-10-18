module lang::daspec::model::Spec

extend lang::daspec::model::Group;


data Spec
  = spec(str \type, str version, list[Datum] datums)
  ;