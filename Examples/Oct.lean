import TinyGA.Oct

open TinyGA Oct

def main : IO Unit := do
  IO.println "Cl(8,0,0): 8 Euclidean directions, 256 blades."
  IO.println "Spinor representations of Spin(8) exhibit triality, and the algebra"
  IO.println "sits next to the octonions. Demoing that gp + sandwich scale to N = 8."

  IO.println ""
  IO.println "rotor in the (e1, e2) plane by pi/2:"
  let R := bivectorRotor (e1.gp e2) (pi / 2.0)
  IO.println s!"  R   = {showo R}"
  let e1Rot := applyRotor R e1
  IO.println s!"  R e1 R~ = {showo e1Rot}   (should equal e2)"

  IO.println ""
  IO.println "rotor in the (e3, e4) plane by pi/2: leaves e1 untouched"
  let S := bivectorRotor (e3.gp e4) (pi / 2.0)
  let e1Held := applyRotor S e1
  IO.println s!"  S e1 S~ = {showo e1Held}   (still e1)"

  IO.println ""
  IO.println "compose: rotate (e1,e2) then (e5,e6); the two planes are orthogonal"
  let T := bivectorRotor (e5.gp e6) (pi / 2.0)
  let composite := T.gp R
  let e1Both := applyRotor composite e1
  IO.println s!"  (T R) e1 (T R)~ = {showo e1Both}   (still maps e1 -> e2; T leaves e1,e2 alone)"

  IO.println ""
  IO.println s!"pseudoscalar I has grade {sig.dim}: {showo I}"
