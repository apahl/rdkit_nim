import ../src/rdkit / [mol, parsers, sss]

proc createLotsOfMolecules() =
  for i in 1 .. 100:
    let
      smi = "c1ccccc1C(=O)NC2CC2" # cyclopropyl benzamide
      m = smilesToMol(smi)
      q = smilesToMol("C1CC1")

    if m.ok:
      let
        na = m.numAtoms
        matches = m.substructMatches(q)

when isMainModule:
  createLotsOfMolecules()


#[Output of `LD_LIBRARY_PATH=/home/pahl/anaconda3/envs/chem/lib valgrind --leak-check=yes ./bin/ex03_mem`:
==2340== LEAK SUMMARY:
==2340==    definitely lost: 4,032 bytes in 56 blocks
==2340==    indirectly lost: 263,256 bytes in 4,508 blocks
==2340==      possibly lost: 0 bytes in 0 blocks
==2340==    still reachable: 687,312 bytes in 11,736 blocks
==2340==         suppressed: 0 bytes in 0 blocks
==2340== Reachable blocks (those to which a pointer was found) are not shown.
==2340== To see them, rerun with: --leak-check=full --show-leak-kinds=all
==2340==
==2340== Use --track-origins=yes to see where uninitialised values come from
==2340== For lists of detected and suppressed errors, rerun with: -s
==2340== ERROR SUMMARY: 253 errors from 48 contexts (suppressed: 0 from 0)

The leak originates from line 13 (matches = m.substructMatches(q)).
]#
