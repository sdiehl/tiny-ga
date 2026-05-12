# tiny-ga

A minimal Geometric Algebra library in Lean 4. About 400 lines of code. Largely
inspired by the textbook *Geometric Algebra for Physicists*.

```
lake build
```

```
lake exe rotor      # Cl(3,0,0) rotors and rotations
lake exe reflect    # Cl(3,0,0) reflections via the sandwich product
lake exe pauli      # Cl(3,0,0) Pauli/quaternion structure
lake exe boost      # Cl(1,3,0) Lorentz boost of a 4-momentum
lake exe emfield    # Cl(1,3,0) F = E + IB invariants under boost
lake exe sta        # Cl(1,3,0) spacetime algebra: 4-momenta, boosts, invariant mass
lake exe cga        # Cl(4,1,0) conformal points, distances, sphere tests
lake exe pga        # Cl(3,0,1) projective GA: planes, intersections, translators
lake exe hyp        # Cl(2,1,0) hyperbolic GA: isometries of H^2
lake exe kepler     # Cl(3,0,0) Kepler orbit with conserved L bivector and LRL vector
lake exe catalog    # Cl(4,1,0) CGA operator catalog by return type
```

- [Rotor.lean](Examples/Rotor.lean) - $\mathrm{Cl}(3,0,0)$ rotors and rotations.
- [Reflect.lean](Examples/Reflect.lean) - $\mathrm{Cl}(3,0,0)$ reflections via the sandwich product $R\,v\,\tilde{R}$.
- [Pauli.lean](Examples/Pauli.lean) - $\mathrm{Cl}(3,0,0)$ Pauli matrix and quaternion structure.
- [Boost.lean](Examples/Boost.lean) - $\mathrm{Cl}(1,3,0)$ Lorentz boost of a 4-momentum.
- [EMField.lean](Examples/EMField.lean) - $\mathrm{Cl}(1,3,0)$ electromagnetic bivector $\mathbf{F} = \mathbf{E} + I\mathbf{B}$ invariants under boost.
- [STA.lean](Examples/STA.lean) - $\mathrm{Cl}(1,3,0)$ four-momenta, boosts, and invariant mass.
- [CGA.lean](Examples/CGA.lean) - $\mathrm{Cl}(4,1,0)$ conformal points, distances, and sphere membership tests.
- [PGA.lean](Examples/PGA.lean) - $\mathrm{Cl}(3,0,1)$ projective planes, intersections, and translators.
- [HYP.lean](Examples/HYP.lean) - $\mathrm{Cl}(2,1,0)$ hyperbolic isometries of $\mathrm{H}^2$ (rotations and boosts).
- [Kepler.lean](Examples/Kepler.lean) - $\mathrm{Cl}(3,0,0)$ Kepler orbit with conserved angular-momentum bivector $L$ and Laplace-Runge-Lenz vector.
- [Catalog.lean](Examples/Catalog.lean) - $\mathrm{Cl}(4,1,0)$ CGA operator catalog grouped by return type, verified by grade fingerprint. See [catalog.md](catalog.md).


## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
