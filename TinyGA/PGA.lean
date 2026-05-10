import TinyGA.Op

namespace TinyGA
namespace PGA

def sig : Sig := ⟨3, 0, 1⟩

abbrev MVp := MV sig Float

def names : Array String :=
  #["1",    "e1",   "e2",   "e12",
    "e3",   "e13",  "e23",  "e123",
    "e0",   "e01",  "e02",  "e012",
    "e03",  "e013", "e023", "I"]

def showp (x : MVp) : String := MV.fmt names x

def e1 : MVp := MV.basis sig 0b0001
def e2 : MVp := MV.basis sig 0b0010
def e3 : MVp := MV.basis sig 0b0100
def e0 : MVp := MV.basis sig 0b1000

def plane (a b c d : Float) : MVp :=
  a * e1 + b * e2 + c * e3 + d * e0

def translator (dx dy dz : Float) : MVp :=
  let bv := dx * (e0.gp e1) + dy * (e0.gp e2) + dz * (e0.gp e3)
  MV.scalar sig 1.0 - (0.5 : Float) * bv

def point (x y z : Float) : MVp :=
  let π1 := plane 1.0 0.0 0.0 (-x)
  let π2 := plane 0.0 1.0 0.0 (-y)
  let π3 := plane 0.0 0.0 1.0 (-z)
  (π1 ∧ π2) ∧ π3

def applyMotor (M : MVp) (X : MVp) : MVp := MV.sandwich M X

end PGA
end TinyGA
