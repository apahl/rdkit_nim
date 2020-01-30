# mol.nim

import ./raw/rdmol

type
  ## The base Mol object
  Mol* = object
    obj*: ptr ROMol

using
  this: Mol

proc destroy*(this: var Mol) =
  this.obj[].destroyROMol()

proc ok*(this): bool =
  ## Returns true when the mol object is valid.
  not this.obj.isNil

proc isNil*(this): bool =
  ## Returns true when the mol object is NOT valid.
  this.obj.isNil

proc molFromSmiles*(smi: string): Mol =
  ## Create a mol object from a SMILES string.
  ##
  ## *Example:* create a molecule and check for success:
  ##
  ## .. code-block::
  ##   import rdkit / [mol, descriptors]
  ##
  ##   let
  ##     smi = "c1ccccc1C(=O)NC2CC2" # cyclopropyl benzamide
  ##     m = molFromSmiles(smi)
  ##
  ##   if m.ok:
  ##     echo m.numAtoms

  # result = new Mol
  let
    cstr = smi.cstring
    s = constructString(cstr)
    p = RdkitSmilesParserParams()
    m = rdkitSmilesToMol(s, p)
  result.obj = m

proc smilesToMol*(smi: string): Mol {.deprecated: "use molFromSmiles instead".} =
  molFromSmiles(smi)

proc molFromSmarts*(sma: string): Mol =
  ## Create a mol object from a SMARTS string.
  # result = new Mol
  let
    cstr = sma.cstring
    s = constructString(cstr)
    m = rdkitSmartsToMol(s)
  result.obj = m

proc smartsToMol*(sma: string): Mol {.deprecated: "use molFromSmarts instead".} =
  molFromSmarts(sma)

proc molToSmiles*(mol: Mol): string =
  let cppSmi = rdkitMolToSmiles(mol.obj[])
  result = $cppSmi.cStr

proc removeHs*(this): Mol =
  let m = rdkitRemoveHs(this.obj[])
  result.obj = m
