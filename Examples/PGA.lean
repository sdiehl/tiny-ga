import TinyGA.PGA

open TinyGA PGA

def main : IO Unit := do
  IO.println "Cl(3,0,1) Projective Geometric Algebra: planes are 1-vectors,"
  IO.println "their wedge is intersection."

  let πx := plane 1.0 0.0 0.0 0.0
  let πy := plane 0.0 1.0 0.0 0.0
  let πz := plane 0.0 0.0 1.0 0.0
  IO.println ""
  IO.println s!"plane x=0  : {showp πx}"
  IO.println s!"plane y=0  : {showp πy}"
  IO.println s!"plane z=0  : {showp πz}"

  let line := πx ∧ πy
  IO.println ""
  IO.println s!"x=0 ∧ y=0  = {showp line}   (the z-axis as a bivector)"

  let pt := line ∧ πz
  IO.println s!"x=0 ∧ y=0 ∧ z=0 = {showp pt}  (the origin as a trivector)"

  IO.println ""
  IO.println "point (1,2,3) constructed from intersecting planes:"
  let P := point 1.0 2.0 3.0
  IO.println s!"  P = {showp P}"

  IO.println ""
  IO.println "translator T = 1 - ½ (dx e01 + dy e02 + dz e03), apply via sandwich"
  let T := translator 10.0 0.0 0.0
  IO.println s!"  T = {showp T}"
  let P' := applyMotor T P
  IO.println s!"  T·P·T~ = {showp P'}"

  IO.println ""
  IO.println "T² = translation by (20,0,0) (translators are exp of null bivectors)"
  let T2 := T.gp T
  IO.println s!"  T² = {showp T2}"
  let P'' := applyMotor T2 P
  IO.println s!"  T²·P·T²~ = {showp P''}"
