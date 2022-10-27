# scaffolds.nim

import ./raw/rdscaf
import molecule

using
  this: Mol

proc murckoMol*(this): Mol =
  ## Generate a Murcko scaffold mol object from a molecule.
  ## A new mol object is returned.
  try:
    let m = rdkitMurckoDecompose(this.obj[])
    result.obj = m
  except:
    result.obj = nil

proc murckoSmiles*(smi: string; ignoreInvalid = false): string {.raises: [ValueError].} =
  ## Generate the Murcko scaffold of a molecule
  ## directly from its Smiles string.
  ## When `ignoreInvalid` is true (default is false),
  ## then invalid molecules are ignored and an empty Smiles string is returned.
  ## Returns a Smiles string of the Murcko scaffold.
  let mol = molFromSmiles(smi)

  if mol.isNil:
    if ignoreInvalid:
      return ""
    else:
      raise newException(ValueError, "Could not generate molecule from Smiles " & smi)

  let murcko = murckoMol(mol)
  result = murcko.toSmiles()
