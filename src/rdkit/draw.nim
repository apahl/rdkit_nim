# draw.nim

import ./raw/cpptypes
import ./raw/rddraw
import molecule

type CoordGenMethod* = enum
  RDKit,
  CoordGen

proc toSVG*(mol: Mol, width = 300, height = 200,
    coordGen: CoordGenMethod = CoordGen): string =
  ## Creates an SVG image of the molecule and returns it as string.
  ## `coordGen` can be either `CoordGen` (default) or `RDKit`.
  if coordGen == CoordGen:
    rdkitPreferCoordGen(true)
  else:
    rdkitPreferCoordGen(false)
  var drawer = rdkitConstructMolDraw2DSVG(width.cint, height.cint)
  drawer.rdkitDrawMol(mol.obj[])
  drawer.rdkitDrawFinish()
  let cppSvg = drawer.rdkitDrawGetText()
  result = $cppSvg.cStr
