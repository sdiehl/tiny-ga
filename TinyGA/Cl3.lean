import TinyGA.Op

namespace TinyGA
namespace Cl3

def sig : Sig := ⟨3, 0, 0⟩

abbrev MV3 := MV sig Float

def names : Array String :=
  #["1", "e1", "e2", "e12", "e3", "e13", "e23", "e123"]

def show3 (x : MV3) : String := MV.fmt names x

def e1 : MV3 := MV.basis sig 0b001
def e2 : MV3 := MV.basis sig 0b010
def e3 : MV3 := MV.basis sig 0b100
def e12 : MV3 := MV.basis sig 0b011
def e13 : MV3 := MV.basis sig 0b101
def e23 : MV3 := MV.basis sig 0b110
def I : MV3 := MV.basis sig 0b111

def vec (x y z : Float) : MV3 :=
  x * e1 + y * e2 + z * e3

def rotor (plane : MV3) (theta : Float) : MV3 :=
  let half := -theta / 2.0
  MV.scalar sig half.cos + half.sin * plane

def rotate (R : MV3) (v : MV3) : MV3 := MV.sandwich R v

def reflect (n : MV3) (v : MV3) : MV3 :=
  MV.neg (MV.sandwich n v)

end Cl3
end TinyGA
