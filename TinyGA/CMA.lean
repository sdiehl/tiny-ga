import TinyGA.Op

namespace TinyGA
namespace CMA

-- Conformal Minkowski algebra Cl(2,4,0): 2 positive, 4 negative, 0 null directions.
-- Underlies twistor theory and the conformal compactification of Minkowski space.
-- 64 blades.
def sig : Sig := ⟨2, 4, 0⟩

abbrev MVcm := MV sig Float

-- Auto-generated blade names: "e<mask>" for each of the 64 masks, scalar tagged "1".
def names : Array String := Id.run do
  let mut out : Array String := Array.mkEmpty sig.numBlades
  for i in [:sig.numBlades] do
    out := out.push (if i == 0 then "1" else s!"e{i}")
  return out

def showcm (x : MVcm) : String := MV.fmt names x

-- Basis vectors. The first two (p1, p2) square to +1, the next four (m1..m4) to -1.
def p1 : MVcm := MV.basis sig 0b000001
def p2 : MVcm := MV.basis sig 0b000010
def m1 : MVcm := MV.basis sig 0b000100
def m2 : MVcm := MV.basis sig 0b001000
def m3 : MVcm := MV.basis sig 0b010000
def m4 : MVcm := MV.basis sig 0b100000

def I : MVcm := MV.pseudoscalar sig

-- Rotor in the plane of a unit bivector that squares to -1 (compact direction).
-- For bivectors squaring to +1 use cosh/sinh instead; this helper assumes the
-- compact case, which matches a rotation in any (pi, pj) or (mi, mj) plane.
def bivectorRotor (bv : MVcm) (theta : Float) : MVcm :=
  let half := theta / 2.0
  MV.scalar sig half.cos - half.sin * bv

def applyRotor (R x : MVcm) : MVcm := MV.sandwich R x

end CMA
end TinyGA
