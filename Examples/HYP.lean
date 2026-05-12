import TinyGA.HYP

open TinyGA HYP

def main : IO Unit := do
  IO.println "Cl(2,1) Hyperbolic Geometric Algebra: isometries of H^2."
  IO.println "Points sit on the upper hyperboloid t^2 - x^2 - y^2 = 1."

  IO.println ""
  let origin := point 0.0 0.0
  IO.println s!"origin (0,0)        : {showh origin}   (=  e0, the apex)"

  let p := point 0.3 0.0
  IO.println s!"point (0.3, 0)      : {showh p}"

  IO.println ""
  IO.println "rotation by pi/2 around origin: (0.3, 0) -> (0, 0.3)"
  let R := rotation (3.141592653589793 / 2.0)
  let pRot := applyIsometry R p
  IO.println s!"  R         = {showh R}"
  IO.println s!"  R p R~    = {showh pRot}"

  IO.println ""
  IO.println "hyperbolic translation along +x by rapidity 0.5"
  let B := boost 1.0 0.0 0.5
  IO.println s!"  B         = {showh B}"
  let oBoosted := applyIsometry B origin
  IO.println s!"  B o B~    = {showh oBoosted}   (= (sinh 0.5) e1 + (cosh 0.5) e0)"

  IO.println ""
  IO.println "composite: rotate, then boost"
  let M := isometry (3.141592653589793 / 4.0) 1.0 0.0 0.3
  IO.println s!"  M         = {showh M}"
  let pMoved := applyIsometry M p
  IO.println s!"  M p M~    = {showh pMoved}"
