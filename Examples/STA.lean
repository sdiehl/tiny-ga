import TinyGA.STA

open TinyGA STA

def main : IO Unit := do
  IO.println "Cl(1,3) Spacetime Algebra: four-momenta and Lorentz boosts."
  IO.println "Inner product (p, p) = E^2 - |p|^2 is the squared rest mass."

  IO.println ""
  let m : Float := 1.0
  let p := fourVec m 0.0 0.0 0.0
  IO.println s!"rest 4-momentum            p = {show4 p}"
  IO.println s!"  p · p = {(p.gp p).get 0}   (expected m^2 = {m*m})"

  IO.println ""
  IO.println "boost along +x with rapidity 1:"
  let phi : Float := 1.0
  let Bx := boost phi (MV.neg (g0.gp g1))
  let p' := applyBoost Bx p
  IO.println s!"  B           = {show4 Bx}"
  IO.println s!"  B p B~      = {show4 p'}"
  IO.println s!"  E = cosh phi = {phi.cosh},  px = sinh phi = {phi.sinh}"
  IO.println s!"  p' · p'     = {(p'.gp p').get 0}   (still m^2)"

  IO.println ""
  IO.println "stack two boosts of rapidity 1 along +x: rapidities add"
  let p'' := applyBoost Bx p'
  IO.println s!"  B^2 p B^{-2} = {show4 p''}"
  IO.println s!"  expected E = cosh 2 = {(2.0:Float).cosh}, px = sinh 2 = {(2.0:Float).sinh}"

  IO.println ""
  IO.println "non-collinear boost: rapidity 0.5 along +y after the +x boost"
  let By := boost 0.5 (MV.neg (g0.gp g2))
  let p'2 := applyBoost By p'
  IO.println s!"  B_y B_x p (B_y B_x)~ = {show4 p'2}"
  IO.println s!"  p · p = {(p'2.gp p'2).get 0}   (Lorentz invariant, still m^2)"
