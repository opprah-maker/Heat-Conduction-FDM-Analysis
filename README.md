# 2D Heat Conduction : Finite Difference Method (MATLAB)

> Transient 2D heat conduction on a square plate solved with the explicit Forward-Time
> Central-Space (FTCS) Finite Difference Method (FDM) in MATLAB. Includes a hand-written
> solver, the full numerical report, and the measured temperature distribution.

[![MATLAB](https://img.shields.io/badge/MATLAB-Orange?logo=mathworks&logoColor=white)]()
[![FDM](https://img.shields.io/badge/Scheme-FTCS%20explicit-blue)]()
[![Report PDF](https://img.shields.io/badge/Report-PDF-red?logo=adobe-acrobat-reader&logoColor=white)]()

[![Open in MATLAB Online](https://img.shields.io/badge/Open%20in-MATLAB%20Online-orange?style=flat-square&logo=mathworks&logoColor=white)](https://matlab.mathworks.com/open/github/v1?repo=opprah-maker/Heat-Conduction-FDM-Analysis&file=heat_conduction_fdm.m)

---

## Table of Contents

1. [Project Overview](#1-project-overview)
2. [Report (PDF)](#2-report-pdf)
3. [Mathematical Model](#3-mathematical-model)
4. [Code](#4-code)
5. [Key Results](#5-key-results)
6. [Figure Reference &amp; Captions](#6-figure-reference--captions)
7. [How to Run](#7-how-to-run)
8. [Topics](#8-topics)

---

## 1. Project Overview

This repository contains a complete transient 2D heat-conduction study on a square plate
solved with the **explicit FTCS** finite-difference scheme. The plate has fixed
temperatures on all four edges (Dirichlet boundary conditions), and the interior is
initialised at T₀ = 25°C. The solver marches forward in time until
steady state is reached.

---

## 2. Report (PDF)

| Document | File |
|---|---|
| Numerical Modelling : 2D Heat Conduction FDM | [`reports/6-Numerical-Modelling.pdf`](reports/6-Numerical-Modelling.pdf) |

---

## 3. Mathematical Model

The 2D transient heat equation on a square domain is

(d T)/(d t) = alpha ((\partial² T)/(d x²) + (\partial² T)/(d y²)), alpha = (k)/(rho cp)

### Discretisation (FTCS)
With uniform grid spacing Delta x = Delta y = h and time step Delta t,

\fracTi,jn⁺¹ - Ti,jnDelta t = alpha [\fracTi₊₁,jn - 2Ti,jn + Ti₋₁,jnh² + \fracTi,j₊₁n - 2Ti,jn + Ti,j₋₁nh²]

Rearranged for the explicit update

Ti,jn⁺¹ = Ti,jn + r(Ti₊₁,jn + Ti₋₁,jn + Ti,j₊₁n + Ti,j₋₁n - 4Ti,jn), r = (alpha Delta t)/(h²)

### Stability
The **von Neumann stability** requirement for the explicit FTCS scheme on a 2D uniform grid
is

r = (alpha Delta t)/(h²) <= (1)/(4) \Longrightarrow Delta t <= (h²)/(4alpha) = 0.25s

The solver computes this limit at run-time and prints a warning if the user-supplied
Delta t violates it.

### Boundary Conditions
| Edge | Temperature |
|---|---|
| Left (x=0) | TL = 100^°C |
| Right (x=L) | TR = 50^°C |
| Top (y=L) | TT = 75^°C |
| Bottom (y=0) | TB = 25^°C |

---

## 4. Code

| File | Purpose |
|---|---|
| [`heatconductionfdm.m`](heatconductionfdm.m) | Main solver: builds the grid, applies Dirichlet BCs, marches in time with the FTCS update, writes `heatdistributionresults.csv` and renders the steady-state contour |
| [`heatdistributionresults.csv`](heatdistributionresults.csv) | Steady-state temperature on the 11 x 11 grid (rows = y index, columns = x index) |
| [`heat-map.jpg`](heat-map.jpg) | Photograph of the original contour plot printed at submission |

---

## 5. Key Results

| Metric | Value |
|---|---|
| Grid resolution | 11 x 11 |
| Time step | Delta t = 0.25s |
| Steady-state time | t_inf ~= 1,500s |
| Centre temperature | T(0,0) ~= 47.7^°C |
| Peak gradient corner | grad T ~= 12.5^°C/unit length |

---

## 6. Figure Reference &amp; Captions

All 16 figures from the heat conduction FDM report. Each is linked to its file in `images/`.

**Figure 1** — Problem setup — square plate with four Dirichlet boundary temperatures and interior initial condition

[![](images/figure-01.png)](images/figure-01.png)

**Figure 2** — Initial temperature distribution — uniform T0 = 25 C at t = 0

[![](images/figure-02.png)](images/figure-02.png)

**Figure 3** — Mesh grid — 11 x 11 uniform spatial grid on [0,1]²

[![](images/figure-03.png)](images/figure-03.png)

**Figure 4** — Boundary conditions — TL = 100 C, TR = 50 C, TT = 75 C, TB = 25 C

[![](images/figure-04.png)](images/figure-04.png)

**Figure 5** — Temperature evolution at t = 100 s — contour plot showing heat diffusion from boundaries

[![](images/figure-05.png)](images/figure-05.png)

**Figure 6** — Temperature evolution at t = 300 s — continued diffusion toward steady state

[![](images/figure-06.png)](images/figure-06.png)

**Figure 7** — Temperature evolution at t = 500 s — approaching steady state

[![](images/figure-07.png)](images/figure-07.png)

**Figure 8** — Temperature evolution at t = 1000 s — near steady state

[![](images/figure-08.png)](images/figure-08.png)

**Figure 9** — Steady-state temperature contour — final temperature distribution on the plate

[![](images/figure-09.png)](images/figure-09.png)

**Figure 10** — Steady-state temperature surface — 3D view of the temperature field

[![](images/figure-10.png)](images/figure-10.png)

**Figure 11** — Centre temperature vs. time — T(0,0) converging to 47.7 C

[![](images/figure-11.png)](images/figure-11.png)

**Figure 12** — Corner temperatures vs. time — convergence to boundary-influenced values

[![](images/figure-12.png)](images/figure-12.png)

**Figure 13** — Convergence history — max |Tn⁺¹ - Tn| vs. iteration count

[![](images/figure-13.png)](images/figure-13.png)

**Figure 14** — Von Neumann stability check — r = alpha dt / h² vs. critical value 0.25

[![](images/figure-14.png)](images/figure-14.png)

**Figure 15** — Mesh refinement study — solution convergence with grid refinement

[![](images/figure-15.png)](images/figure-15.png)

**Figure 16** — Comparison with analytical solution — steady-state error vs. grid spacing

[![](images/figure-16.png)](images/figure-16.png)


---

## 7. How to Run

### 7.1 Requirements
- MATLAB R2018a or later **OR** GNU Octave 5.x or later

### 7.2 Run the solver
```matlab
% From the repository root
heatconductionfdm
```
The script will:
1. Build an 11 x 11 spatial grid on [0,1]²
2. Apply the four Dirichlet boundary temperatures
3. March in time with the FTCS update until |Tn⁺¹ - Tn|_inf < 10⁻³
4. Write the steady-state field to `heatdistributionresults.csv`
5. Plot the steady-state temperature contour (matches `images/`)

### 7.3 Verify the stability criterion
Inside the script, the line
```matlab
dtmax = h² / (4 * alpha);
assert(dt <= dtmax, 'FTCS stability violated');
```
enforces the von Neumann condition. If you change h or alpha, this guard will fail
before the time loop starts.

---

## 8. Topics

`finite-difference-method` `numerical-methods` `heat-conduction` `matlab` `ftcs-scheme`
`pde-solver` `von-neumann-stability` `thermal-analysis` `computational-physics`
`engineering-simulation`
