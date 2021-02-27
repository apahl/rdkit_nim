# molecule.nim

import ./raw/cpptypes
import ./raw/rdmol

type
  ## The base Mol object
  Mol* = object
    obj*: ptr ROMol

using
  this: Mol

proc `=destroy`*(this: var Mol) =
  if not this.obj.isNil:
    this.obj[].destroyROMol()

proc ok*(this): bool =
  ## Returns true when the mol object is valid.
  not this.obj.isNil

proc isNil*(this): bool =
  ## Returns true when the mol object is NOT valid.
  this.obj.isNil

proc molFromSmiles*(smi: string): Mol =
  ## Create a mol object from a SMILES string.
  ## The molecule is returned as an Option[Mol].
  ##
  ## Create a molecule and check for success.
  ##
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
    m = rdkitSmilesToMol(s, p)
  result.obj = m

proc molFromSmarts*(sma: string): Mol =
  ## Create a mol object from a SMARTS string.
  ## The molecule is returned as an Option[Mol].
  # result = new Mol
  let
    cstr = sma.cstring
    s = constructString(cstr)
    m = rdkitSmartsToMol(s)
  result.obj = m

proc molDefault*(): Mol =
  ## Create a default mol obhect,
  ## which is the no-structure ("*")
  molFromSmiles("*")

proc toSmiles*(mol: Mol): string =
  let cppSmi = rdkitMolToSmiles(mol.obj[])
  result = $cppSmi.cStr

proc toMolBlock*(mol: Mol): string =
  let cppSmi = rdkitMolToMolBlock(mol.obj[])
  result = $cppSmi.cStr

proc removeHs*(this): Mol =
  let m = rdkitRemoveHs(this.obj[])
  result.obj = m
