module lang::quanda::util::Implode

import lang::quanda::ast::Quanda;
import lang::quanda::syntax::Quanda;

import ParseTree;

public lang::quanda::ast::Quanda::Form implode(lang::quanda::syntax::Quanda::Form pt) {
  return implode(#lang::quanda::ast::Quanda::Form, pt);
}