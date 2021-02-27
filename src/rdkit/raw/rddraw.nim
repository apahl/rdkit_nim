# raw/rddraw.nim

import os # `/`, getEnv
import ./cpptypes
import ./rdmol

const
  condaPath = getEnv("RDKIT_CONDA")
  depictHeader = condaPath / "include/rdkit/GraphMol/Depictor/RDDepictor.h"
  svgHeader = condaPath / "include/rdkit/GraphMol/MolDraw2D/MolDraw2DSVG.h"

{.passL: "-lRDKitMolDraw2D".}
{.passL: "-lRDKitcoordgen".}
{.passL: "-lRDKitDepictor".}

type
  MolDraw2DSVG* {.final, header: svgHeader,
    importcpp: "RDKit::MolDraw2DSVG".} = object

proc rdkitPreferCoordGen*(value: bool) {.
    importcpp: "RDDepict::preferCoordGen = #", header: depictHeader.}

proc rdkitCompute2DCoords*(mol: ROMol) {.
    importcpp: "RDKit::RDDepict::compute2DCoords(@)", header: depictHeader.}

proc rdkitConstructMolDraw2DSVG*(width, height: cint): MolDraw2DSVG {.
    importcpp: "RDKit::MolDraw2DSVG(@)", constructor, header: svgHeader.}

proc rdkitDrawMol*(this: MolDraw2DSVG, mol: ROMol) {.
    importcpp: "#.drawMolecule(@)", header: svgHeader.}

proc rdkitDrawFinish*(this: MolDraw2DSVG) {.importcpp: "#.finishDrawing()",
    header: svgHeader.}

proc rdkitDrawGetText*(this: MolDraw2DSVG): CppString {.
    importcpp: "#.getDrawingText()", header: svgHeader.}

# RDDepict::preferCoordGen = true;
# RDDepict::compute2DCoords( *mol1 );
# RDDepict::compute2DCoords( *mol , nullptr , true );

# type
#   StdMap {.importcpp: "std::map", header: "<map>".} [K, V] = object
# proc `[]=`[K, V](this: var StdMap[K, V]; key: K; val: V) {.
#   importcpp: "#[#] = #", header: "<map>".}
