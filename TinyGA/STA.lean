import TinyGA.Op

namespace TinyGA
namespace STA

def sig : Sig := ⟨1, 3, 0⟩

abbrev MV4 := MV sig Float

def names : Array String :=
  #["1",   "g0",   "g1",   "g01",
    "g2",  "g02",  "g12",  "g012",
    "g3",  "g03",  "g13",  "g013",
    "g23", "g023", "g123", "I"]

def show4 (x : MV4) : String := MV.fmt names x

def g0 : MV4 := MV.basis sig 0b0001
def g1 : MV4 := MV.basis sig 0b0010
def g2 : MV4 := MV.basis sig 0b0100
def g3 : MV4 := MV.basis sig 0b1000

def fourVec (t x y z : Float) : MV4 :=
  t * g0 + x * g1 + y * g2 + z * g3

def boost (rapidity : Float) (dir : MV4) : MV4 :=
  let half := rapidity / 2.0
  let c := half.cosh
  let σ := half.sinh
  MV.scalar sig c + σ * dir

def applyBoost (B : MV4) (v : MV4) : MV4 :=
  MV.sandwich B v

end STA
end TinyGA
