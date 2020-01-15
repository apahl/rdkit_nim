# mol.nim

import raw/rdmol

type
  Mol* = ref object
    obj*: ptr RWMol

using
  this: Mol

proc ok*(this): bool =
  not this.obj.isNil

proc isNil*(this): bool =
  this.obj.isNil


proc numAtoms*(this): uint =
  uint(this.obj[].rdkitNumAtoms)
