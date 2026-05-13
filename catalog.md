# CGA Operator Catalog

CGA Cl(4,1) operator catalog, grouped by the grade of the result.

## Object types

| Code | Type            | Grade | Constructor                             |
| ---- | --------------- | ----- | --------------------------------------- |
| Pnt  | Point           | 1     | `point x y z`                           |
| Par  | Point Pair      | 2     | `p1 ∧ p2`                               |
| Cir  | Circle          | 3     | `p1 ∧ p2 ∧ p3`                          |
| Sph  | Sphere (OPNS)   | 4     | `p1 ∧ p2 ∧ p3 ∧ p4`                     |
| Flp  | Flat Point      | 2     | `p ∧ ni`                                |
| Lin  | Line            | 3     | `p1 ∧ p2 ∧ ni`                          |
| Pln  | Plane           | 4     | `p1 ∧ p2 ∧ p3 ∧ ni`                     |
| Dlp  | Dual Plane      | 1     | `n + d ni`, `n` a unit Euclidean vector |
| Dll  | Dual Line       | 2     | `Dlp1 ∧ Dlp2`                           |
| Drv  | Direction Vec   | 2     | `v ∧ ni`                                |
| Pss  | Pseudoscalar    | 5     | `I5 = e1 e2 e3 ep em`                   |
| Ori  | Origin          | 1     | `no`                                    |
| Inf  | Infinity        | 1     | `ni`                                    |
| Mnk  | Minkowski Plane | 2     | `no ∧ ni`                               |
| Rot  | Rotor           | 0,2   | `cos(t/2) - sin(t/2) B`                 |
| Trs  | Translator      | 0,2   | `1 - (1/2) t ni`                        |
| Mot  | Motor           | 0,2,4 | `Trs * Rot`                             |
| Dil  | Dilator         | 0,2   | `cosh(a/2) + sinh(a/2) Mnk`             |

## Operators

| Symbol | Lean  | Name              |
| ------ | ----- | ----------------- |
| `*`    | `.gp` | geometric product |
| `∧`    | `∧`   | outer (wedge)     |
| `⌋`    | `⌋`   | left contraction  |

## Operations that Construct a Point (grade 1)

| Formula     | Grade arithmetic |
| ----------- | ---------------- |
| `Pss * Sph` | 5 * 4 -> 1       |
| `Par ⌋ Cir` | 2 ⌋ 3 -> 1       |
| `Par ⌋ Lin` | 2 ⌋ 3 -> 1       |
| `Cir ⌋ Sph` | 3 ⌋ 4 -> 1       |
| `Cir ⌋ Pln` | 3 ⌋ 4 -> 1       |
| `Vec ⌋ Par` | 1 ⌋ 2 -> 1       |
| `Biv ⌋ Cir` | 2 ⌋ 3 -> 1       |
| `Dlp ⌋ Par` | 1 ⌋ 2 -> 1       |

## Operations that Construct a Point Pair (grade 2 round)

| Formula     | Grade arithmetic |
| ----------- | ---------------- |
| `Pss * Cir` | 5 * 3 -> 2       |
| `Pnt ∧ Pnt` | 1 + 1 -> 2       |
| `Pnt ⌋ Cir` | 1 ⌋ 3 -> 2       |
| `Pnt ⌋ Lin` | 1 ⌋ 3 -> 2       |
| `Vec ⌋ Cir` | 1 ⌋ 3 -> 2       |

## Operations that Construct a Circle (grade 3 round)

| Formula     | Grade arithmetic |
| ----------- | ---------------- |
| `Pss * Par` | 5 * 2 -> 3       |
| `Pnt ∧ Par` | 1 + 2 -> 3       |
| `Pnt ⌋ Pln` | 1 ⌋ 4 -> 3       |

## Operations that Construct a Sphere (grade 4 round, OPNS)

| Formula     | Grade arithmetic |
| ----------- | ---------------- |
| `Pss * Pnt` | 5 * 1 -> 4       |
| `Pnt ∧ Cir` | 1 + 3 -> 4       |
| `Par ∧ Par` | 2 + 2 -> 4       |
| `Cir ∧ Vec` | 3 + 1 -> 4       |

## Operations that Construct a Line (grade 3 flat)

| Formula     | Grade arithmetic |
| ----------- | ---------------- |
| `Inf ∧ Par` | 1 + 2 -> 3       |
| `Pss * Dll` | 5 * 2 -> 3       |
| `Pnt ∧ Drv` | 1 + 2 -> 3       |

## Operations that Construct a Plane (grade 4 flat)

| Formula     | Grade arithmetic |
| ----------- | ---------------- |
| `Inf ∧ Cir` | 1 + 3 -> 4       |
| `Pnt ∧ Lin` | 1 + 3 -> 4       |
| `Par ∧ Drv` | 2 + 2 -> 4       |

## Operations that Construct a Flat Point (grade 2 flat)

| Formula       | Grade arithmetic |
| ------------- | ---------------- |
| `Inf ∧ Pnt`   | 1 + 1 -> 2       |
| `flatPoint p` | by construction  |

## Operations that Construct a Direction Vector (grade 2 flat)

| Formula     | Grade arithmetic |
| ----------- | ---------------- |
| `Inf ∧ Vec` | 1 + 1 -> 2       |
| `Inf ⌋ Lin` | 1 ⌋ 3 -> 2       |

## Operations that Construct a Pseudoscalar (grade 5)

| Formula     | Grade arithmetic |
| ----------- | ---------------- |
| `Pnt ∧ Sph` | 1 + 4 -> 5       |
| `Par ∧ Cir` | 2 + 3 -> 5       |
| `I5`        | the basis blade  |

## Origin, Infinity, Minkowski plane

| Formula   | Grade |
| --------- | ----- |
| `no`      | 1     |
| `ni`      | 1     |
| `no ∧ ni` | 2     |

## Operations that Construct a Versor

| Formula               | Grades |
| --------------------- | ------ |
| `rotor B t`           | 0,2    |
| `translator tx ty tz` | 0,2    |
| `motor B t tx ty tz`  | 0,2,4  |
| `dilator a`           | 0,2    |
