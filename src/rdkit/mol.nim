# mol.nim

import raw/rdmol

type
  ## The base Mol object
  Mol* = ptr ROMol

using
  this: Mol

proc ok*(this): bool =
  ## Returns true when the mol object is valid.
  not this.isNil

proc isNil*(this): bool =
  ## Returns true when the mol object is NOT valid.
  this.isNil

proc numAtoms*(this): uint =
  ## Returns the number of heavy atoms.
  uint(this[].rdkitNumAtoms)

proc molWt*(this): float64 =
  ## Returns the avergage mol weight.
  float64(this[].rdkitMolWt)

proc numHBD*(this): uint =
  ## Returns the number of hydrogen bond donors.
  uint(this[].rdkitNumHBD)

proc numHBA*(this): uint =
  ## Returns the number of hydrogen bond acceptors.
  uint(this[].rdkitNumHBA)

proc numRotatableBonds*(this): uint =
  ## Returns the number of rotatable bonds.
  uint(this[].rdkitNumRotatableBonds)

proc numHeteroAtoms*(this): uint =
  ## Returns the number of hetero atoms.
  uint(this[].rdkitNumHeteroatoms)

proc fractionCSP3*(this): float64 =
  ## Returns the fraction of sp3-hybridized C-atoms in the molecule.
  float64(this[].rdkitFractionCSP3)

proc numRings*(this): uint =
  ## Returns the total number of rings.
  uint(this[].rdkitNumRings)

proc cLogP*(this): float64 =
  ## Returns the LogP of the molecule.
  float64(this[].rdkitClogP)




