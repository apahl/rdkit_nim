# mol.nim

import ./raw/rddesc
import mol

using
  this: Mol

proc numAtoms*(this): uint =
  ## Returns the number of heavy atoms.
  uint(this.obj[].rdkitNumAtoms)

proc molWt*(this): float64 =
  ## Returns the avergage mol weight.
  float64(this.obj[].rdkitMolWt)

proc numHBD*(this): uint =
  ## Returns the number of hydrogen bond donors.
  uint(this.obj[].rdkitNumHBD)

proc numHBA*(this): uint =
  ## Returns the number of hydrogen bond acceptors.
  uint(this.obj[].rdkitNumHBA)

proc numRotatableBonds*(this): uint =
  ## Returns the number of rotatable bonds.
  uint(this.obj[].rdkitNumRotatableBonds)

proc numHeteroAtoms*(this): uint =
  ## Returns the number of hetero atoms.
  uint(this.obj[].rdkitNumHeteroatoms)

proc fractionCSP3*(this): float64 =
  ## Returns the fraction of sp3-hybridized C-atoms in the molecule.
  float64(this.obj[].rdkitFractionCSP3)

proc numRings*(this): uint =
  ## Returns the total number of rings.
  uint(this.obj[].rdkitNumRings)

proc cLogP*(this): float64 =
  ## Returns the LogP of the molecule.
  float64(this.obj[].rdkitClogP)

proc tPSA*(this): float64 =
  ## Returns the topological Polar Surface Area (TPSA) of the molecule.
  float64(this.obj[].rdkitTPSA)

proc findSSSR*(this): int =
  ## Returns the Smallest Set of Smallest Rings.
  int(this.obj[].rdkitFindSSSR)

