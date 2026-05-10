namespace TinyGA

structure Sig where
  p : Nat
  q : Nat
  r : Nat
deriving Repr, DecidableEq

def Sig.dim (s : Sig) : Nat := s.p + s.q + s.r

def Sig.numBlades (s : Sig) : Nat := 1 <<< s.dim

def Sig.basisSign (s : Sig) (i : Nat) : Int :=
  if i < s.p then 1
  else if i < s.p + s.q then -1
  else 0

def Sig.metricSign (s : Sig) (mask : Nat) : Int :=
  let rec go (i fuel : Nat) (acc : Int) : Int :=
    match fuel with
    | 0 => acc
    | k+1 =>
      if (mask >>> i) &&& 1 = 1 then
        let m := s.basisSign i
        if m = 0 then 0 else go (i+1) k (acc * m)
      else go (i+1) k acc
  go 0 s.dim 1

end TinyGA
