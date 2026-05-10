# tiny-ga

A minimal, pedagogical Geometric Algebra library in Lean 4.

## Build

```
lake build
```

## Examples

```
lake exe rotor      # rotors and rotations in Cl(3,0)
lake exe reflect    # reflections via the sandwich product
lake exe pauli      # Pauli/quaternion structure inside Cl(3,0)
lake exe boost      # Lorentz boost of a 4-momentum in Cl(1,3)
lake exe emfield    # F = E + IB invariants under boost
lake exe cga        # conformal points, distances, sphere tests
lake exe pga        # Cl(3,0,1) projective GA: planes, intersections, translators
lake exe kepler     # orbit in Cl(3,0) with conserved L bivector and LRL vector
```

## License

MIT.
