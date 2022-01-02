# molecule.nim

import ./raw/cpptypes
import ./raw/rdmol

type
  ## The base Mol object
  Mol* = object
    obj*: ptr ROMol

using
  this: Mol

# proc `=destroy`*(this: var Mol) =
#   if not this.obj.isNil:
#     this.obj[].destroyROMol()

proc ok*(this): bool =
  ## Returns true when the mol object is valid.
  not this.obj.isNil

proc isNil*(this): bool =
  ## Returns true when the mol object is NOT valid.
  this.obj.isNil

proc molFromSmiles*(smi: string): Mol =
  ## Create a mol object from a SMILES string.
  ## The object will be nil when no molecule could be generated.
  ## This can be checked with `mol.ok` or `mol.isNil`
  runnableExamples:
    import molecule, descriptors

    let
      smi = "c1ccccc1C(=O)NC2CC2" # cyclopropyl benzamide
      m = molFromSmiles(smi)
    if m.ok:
      echo m.numAtoms

  # result = new Mol
  let
    cstr = smi.cstring
    s = constructString(cstr)
    p = RdkitSmilesParserParams()
  try:
    let m = rdkitSmilesToMol(s, p)
    result.obj = m
  except:
    result.obj = nil

proc molFromSmarts*(sma: string): Mol =
  ## Create a mol object from a SMARTS string.
  let
    cstr = sma.cstring
    s = constructString(cstr)
    m = rdkitSmartsToMol(s)
  result.obj = m

proc molDefault*(): Mol =
  ## Create a default mol object,
  ## which is the no-structure ("*")
  molFromSmiles("*")

proc toSmiles*(this): string =
  let cppSmi = rdkitMolToSmiles(this.obj[])
  result = $cppSmi.cStr

proc toMolBlock*(this): string =
  let cppSmi = rdkitMolToMolBlock(this.obj[])
  result = $cppSmi.cStr

proc removeHs*(this): Mol =
  let m = rdkitRemoveHs(this.obj[])
  result.obj = m

proc ringAtoms*(this): seq[seq[int]] =
  ## Returns a list of list of atom indices in rings.
  let ringAtoms = rdkitAtomRings(this.obj[])
  if ringAtoms.isEmpty:
    return result
  for ratoms in ringAtoms:
    var atoms: seq[int]
    for ra in ratoms:
      atoms.add(ra)
    result.add(atoms)

proc numRingsSizeGE*(this; n: int): int =
  ## Returns the number of rings with size greater or equal than the given `n` in the molecule.
  ## Example: `mol.numRingsSizeGE(7)` gives the number of rings with 7 or more atoms in `mol`.
  # No need to call `ringAtoms` and iterate over the Nim seqs.
  # Just directly check the lengths of the CPP vectors.
  for ra in rdkitAtomRings(this.obj[]):
    if int(ra.len) >= n:
      result += 1

proc largestRing*(this): int =
  ## Returns the size of the largest ring in the molecule.
  # No need to call `ringAtoms` and iterate over the Nim seqs.
  # Just directly check the lengths of the CPP vectors.
  for ra in rdkitAtomRings(this.obj[]):
    let l = int(ra.len)
    if l > result:
      result = l

# proc sanitize*(this) =
#   rdkitSanitizeMol(this.obj)
