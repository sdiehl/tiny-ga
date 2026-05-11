import TinyGA.CGA

open TinyGA CGA

def padR (s : String) (n : Nat) : String :=
  s ++ String.ofList (List.replicate (n - s.length) ' ')

def gradesOf (x : MVc) : List Nat := Id.run do
  let mut seen : Array Bool := Array.replicate 6 false
  for i in [:CGA.sig.numBlades] do
    if (x.coeffs.getD i 0.0).abs > 1e-9 then
      seen := seen.set! (TinyGA.grade i CGA.sig.dim) true
  let mut out : List Nat := []
  for g in [0:6] do
    if seen.getD g false then out := out ++ [g]
  return out

def fp (x : MVc) : String :=
  "[" ++ String.intercalate "," ((gradesOf x).map toString) ++ "]"

def isNull (x : MVc) : Bool := ((x.gp x).get 0).abs < 1e-7

def isZero (x : MVc) : Bool := Id.run do
  let mut m := 0.0
  for i in [:CGA.sig.numBlades] do
    let c := (x.coeffs.getD i 0.0).abs
    if c > m then m := c
  return m < 1e-7

def isFlat (x : MVc) : Bool := isZero (x ∧ ni)

def sec (title : String) : IO Unit := do
  IO.println ""
  IO.println s!"=== {title} ==="

def row (formula : String) (grades : List Nat) (x : MVc) : IO Unit :=
  let gs := gradesOf x
  let ok := gs == grades
  let flag := if ok then "ok  " else "FAIL"
  let tags := (if isNull x then "null " else "     ") ++
              (if isFlat x then "flat" else "    ")
  IO.println s!"  {padR formula 16}grades={padR (fp x) 12}{padR tags 11}[{flag}]"

def main : IO Unit := do
  IO.println "CGA Cl(4,1) operator catalog, grouped by return type."
  IO.println "  grades=[k...] are the grades with nonzero coefficients in the result."
  IO.println "  null = X*X has zero scalar part; flat = X wedge ni vanishes."

  let px := point 1.0 0.0 0.0
  let py := point 0.0 1.0 0.0
  let pz := point 0.0 0.0 1.0
  let pq := point 1.0 1.0 0.0
  let p1 := point 2.0 0.0 0.0

  let par   := pointPair px py
  let cir   := circle px py pq
  let sphR  := sphereOPNS px py pq p1
  let lin   := line px py
  let pln   := plane px py pq
  let drv   := directionVec 1.0 0.0 0.0
  let vx    := vec3 1.0 0.0 0.0
  let biv12 := e1.gp e2

  sec "Operations that Construct a Point"
  row "Pss * Sph"   [1] (I5.gp sphR)
  row "Par ⌋ Cir"   [1] (par ⌋ cir)
  row "Par ⌋ Lin"   [1] (par ⌋ lin)
  row "Cir ⌋ Sph"   [1] (cir ⌋ sphR)
  row "Cir ⌋ Pln"   [1] (cir ⌋ pln)
  row "Vec ⌋ Par"   [1] (vx ⌋ par)
  row "Biv ⌋ Cir"   [1] (biv12 ⌋ cir)
  row "Dlp ⌋ Par"   [1] (dualPlane 1.0 0.0 0.0 0.0 ⌋ par)

  sec "Operations that Construct a Point Pair (grade 2 round)"
  row "Pss * Cir"   [2] (I5.gp cir)
  row "Pnt ∧ Pnt"   [2] (px ∧ py)
  row "Pnt ⌋ Cir"   [2] (px ⌋ cir)
  row "Pnt ⌋ Lin"   [2] (px ⌋ lin)
  row "Vec ⌋ Cir"   [2] (vx ⌋ cir)

  sec "Operations that Construct a Circle (grade 3 round)"
  row "Pss * Par"   [3] (I5.gp par)
  row "Pnt ∧ Par"   [3] (pz ∧ par)
  row "Pnt ⌋ Pln"   [3] (px ⌋ pln)

  sec "Operations that Construct a Sphere (grade 4 OPNS)"
  row "Pss * Pnt"   [4] (I5.gp px)
  row "Pnt ∧ Cir"   [4] (p1 ∧ cir)
  row "Par ∧ Par"   [4] (par ∧ pointPair pz p1)
  row "Cir ∧ Vec"   [4] (cir ∧ e3)

  sec "Operations that Construct a Line (grade 3 flat)"
  row "Inf ∧ Par"   [3] (ni ∧ par)
  row "Pss * Dll"   [3] (I5.gp ((dualPlane 1.0 0.0 0.0 0.0) ∧ (dualPlane 0.0 1.0 0.0 0.0)))
  row "Pnt ∧ Drv"   [3] (px ∧ drv)

  sec "Operations that Construct a Plane (grade 4 flat)"
  row "Inf ∧ Cir"   [4] (ni ∧ cir)
  row "Pnt ∧ Lin"   [4] (pz ∧ lin)
  row "Par ∧ Drv"   [4] (par ∧ directionVec 0.0 0.0 1.0)

  sec "Operations that Construct a Flat Point (grade 2 flat)"
  row "Inf ∧ Pnt"   [2] (ni ∧ px)
  row "flatPoint px" [2] (flatPoint px)

  sec "Operations that Construct a Direction Vector (grade 2 flat)"
  row "Inf ∧ Vec"   [2] (ni ∧ vx)
  row "Inf ⌋ Lin"   [2] (ni ⌋ lin)

  sec "Operations that Construct a Pseudoscalar (grade 5)"
  row "Pnt ∧ Sph"   [5] (pz ∧ sphR)
  row "Par ∧ Cir"   [5] (par ∧ circle pz p1 (point 0.5 0.5 0.5))
  row "I5 literal"  [5] I5

  sec "Origin / Infinity / Minkowski plane"
  row "origin (no)" [1] origin
  row "infinity ni" [1] infinity
  row "no ∧ ni"     [2] minkowskiPlane

  sec "Operations that Construct a Versor (Rotor / Translator / Motor / Dilator)"
  row "rotor π/2 e12"  [0, 2]    (rotor biv12 (pi / 2.0))
  row "translator"     [0, 2]    (translator 1.0 0.0 0.0)
  row "motor"          [0, 2, 4] (motor biv12 (pi / 2.0) 0.0 0.0 1.0)
  row "dilator α=1"    [0, 2]    (dilator 1.0)
