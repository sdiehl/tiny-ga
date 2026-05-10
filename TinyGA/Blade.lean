import TinyGA.Sig

namespace TinyGA

def popCount (n bits : Nat) : Nat :=
  let rec loop (i acc : Nat) : Nat :=
    match i with
    | 0 => acc
    | j+1 => loop j (acc + ((n >>> j) &&& 1))
  loop bits 0

def grade (mask bits : Nat) : Nat := popCount mask bits

def swapSign (a b bits : Nat) : Int :=
  let rec loop (i count : Nat) : Nat :=
    match i with
    | 0 => count
    | j+1 =>
      let above := a >>> (j + 1)
      let bit_b := (b >>> j) &&& 1
      let pairs := if bit_b = 1 then popCount above (bits - j - 1) else 0
      loop j (count + pairs)
  if (loop bits 0) % 2 = 0 then 1 else -1

def bladeProduct (s : Sig) (a b : Nat) : Int × Nat :=
  let m := s.metricSign (a &&& b)
  if m = 0 then (0, 0)
  else (swapSign a b s.dim * m, a ^^^ b)

end TinyGA
