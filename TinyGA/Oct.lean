import TinyGA.Op

namespace TinyGA
namespace Oct

-- Cl(8,0,0): 8 Euclidean directions, 256 blades. The spinor representations of
-- the spin group exhibit triality, and the algebra sits next to the octonions
-- (which live inside the Cl(0,7,0)-flavoured construction). Mostly here to
-- demonstrate that the same machinery scales to N = 8 unchanged.
def sig : Sig := ⟨8, 0, 0⟩

abbrev MVo := MV sig Float

-- Auto-generated 256-entry blade name table.
def names : Array String := Id.run do
  let mut out : Array String := Array.mkEmpty sig.numBlades
  for i in [:sig.numBlades] do
    out := out.push (if i == 0 then "1" else s!"e{i}")
  return out

def showo (x : MVo) : String := MV.fmt names x

-- All eight basis vectors. Each squares to +1.
def e1 : MVo := MV.basis sig 0b00000001
def e2 : MVo := MV.basis sig 0b00000010
def e3 : MVo := MV.basis sig 0b00000100
def e4 : MVo := MV.basis sig 0b00001000
def e5 : MVo := MV.basis sig 0b00010000
def e6 : MVo := MV.basis sig 0b00100000
def e7 : MVo := MV.basis sig 0b01000000
def e8 : MVo := MV.basis sig 0b10000000

def I : MVo := MV.pseudoscalar sig

-- Rotor in a bivector plane that squares to -1 (any e_i ∧ e_j with i ≠ j here).
def bivectorRotor (bv : MVo) (theta : Float) : MVo :=
  let half := theta / 2.0
  MV.scalar sig half.cos - half.sin * bv

def applyRotor (R x : MVo) : MVo := MV.sandwich R x

end Oct
end TinyGA
