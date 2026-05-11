# tiny-ga

A minimal Geometric Algebra library in Lean 4. About 400 lines of code. Largely
inspired by the textbook *Geometric Algebra for Physicists*.

```
lake build
```

```
lake exe rotor      # rotors and rotations in Cl(3,0)
lake exe reflect    # reflections via the sandwich product
lake exe pauli      # Pauli/quaternion structure inside Cl(3,0)
lake exe boost      # Lorentz boost of a 4-momentum in Cl(1,3)
lake exe emfield    # F = E + IB invariants under boost
lake exe cga        # conformal points, distances, sphere tests
lake exe pga        # Cl(3,0,1) projective GA: planes, intersections, translators
lake exe kepler     # orbit in Cl(3,0) with conserved L bivector and LRL vector
lake exe catalog    # CGA operator catalog by return type
```

- [Rotor.lean](Examples/Rotor.lean) - rotors and rotations in $\mathrm{Cl}(3,0)$.
- [Reflect.lean](Examples/Reflect.lean) - reflections via the sandwich product $R\,v\,\tilde{R}$.
- [Pauli.lean](Examples/Pauli.lean) - Pauli matrix and quaternion structure inside $\mathrm{Cl}(3,0)$.
- [Boost.lean](Examples/Boost.lean) - Lorentz boost of a 4-momentum in $\mathrm{Cl}(1,3)$.
- [EMField.lean](Examples/EMField.lean) - electromagnetic bivector $\mathbf{F} = \mathbf{E} + I\mathbf{B}$ invariants under boost.
- [CGA.lean](Examples/CGA.lean) - conformal points, distances, and sphere membership tests in $\mathrm{Cl}(4,1)$.
- [PGA.lean](Examples/PGA.lean) - projective planes, intersections, and translators in $\mathrm{Cl}(3,0,1)$.
- [Kepler.lean](Examples/Kepler.lean) - Kepler orbit with conserved angular-momentum bivector $L$ and Laplace-Runge-Lenz vector.
- [Catalog.lean](Examples/Catalog.lean) - CGA operator catalog grouped by return type, verified by grade fingerprint. See [catalog.md](catalog.md).


## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
