import TinyGA.CMA

open TinyGA CMA

def main : IO Unit := do
  IO.println "Cl(2,4,0) Conformal Minkowski Algebra: 64 blades, signature (++----)."
  IO.println "Underlies twistor theory and the conformal compactification of Minkowski space."

  IO.println ""
  IO.println "basis-vector squares (sign coming from the metric):"
  IO.println s!"  p1 * p1 = {showcm (p1.gp p1)}     (positive direction)"
  IO.println s!"  m1 * m1 = {showcm (m1.gp m1)}     (negative direction)"

  IO.println ""
  IO.println "rotor in the (p1, p2) plane by pi/3:"
  let R := bivectorRotor (p1.gp p2) (pi / 3.0)
  IO.println s!"  R   = {showcm R}"
  let p1Rot := applyRotor R p1
  IO.println s!"  R p1 R~ = {showcm p1Rot}   (= cos(pi/3) p1 + sin(pi/3) p2)"

  IO.println ""
  IO.println "rotor in the (m1, m2) plane by pi/4 (also a compact direction since"
  IO.println "the bivector m1∧m2 squares to (m1·m1)(m2·m2) sign-cancelling to -1):"
  let R2 := bivectorRotor (m1.gp m2) (pi / 4.0)
  let m1Rot := applyRotor R2 m1
  IO.println s!"  R2 m1 R2~ = {showcm m1Rot}"

  IO.println ""
  IO.println s!"pseudoscalar I has grade {sig.dim}: {showcm I}"
