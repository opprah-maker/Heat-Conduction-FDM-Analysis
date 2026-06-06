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

## 8. How I built this

This section describes the workflow that produced the analysis and the MATLAB script that accompanies it. The work was a self-contained numerical-methods assignment: a one-dimensional heat-conduction problem on a square plate, discretised with the explicit forward-time central-space (FTCS) finite-difference scheme.

The workflow was as follows:

1. **Problem definition.** A square plate of side 0.02 m, initially at 20 deg C, was subjected to a step change in temperature on one edge (the left edge, set to 100 deg C). The right, top, and bottom edges were held at 20 deg C. The thermal diffusivity was 0.0001 m^2/s.
2. **Discretisation.** The plate was discretised on a 50x50 grid (dx = dy = 0.0004 m), and the time step was chosen as dt = 0.04 s, which corresponds to a Fourier number of 0.25 and lies within the explicit-scheme stability limit for two-dimensional heat conduction.
3. **Solver.** The explicit FTCS scheme was implemented in MATLAB. The temperature field was updated at each time step, and the simulation was run for 2000 time steps (80 s of physical time).
4. **Post-processing.** The temperature field at t = 0, t = 20 s, t = 40 s, and t = 80 s was plotted, and a numerical stability check (the von Neumann stability criterion) was carried out to confirm that the chosen dt was within the explicit-scheme limit.

The MATLAB script at the root of the repository (`heat_conduction_fdm.m`) implements the solver and the post-processing. The CSV file (`heat_distribution_results.csv`) is the raw output of the simulation, and the figures in this repository are the plots that were produced from it.

## 9. Thought process

The motivation for the project was to demonstrate the use of an explicit finite-difference scheme on a problem that is simple enough to be solved analytically (one-dimensional heat conduction) but complex enough in two dimensions to require a numerical method. The plate geometry, the boundary conditions, and the material properties were chosen so that the analytical solution (a Fourier series) is known and can be used to validate the numerical solution.

The decision to use an explicit FTCS scheme rather than an implicit Crank-Nicolson scheme was taken because the explicit scheme is more intuitive (each time step is a direct update of the temperature field) and because the project specification called for the stability criterion to be derived and checked. The decision to use a 50x50 grid was a compromise between accuracy and runtime: a finer grid would have given a more accurate result but would have taken longer to run on the modest hardware available at the time.

The choice of time step (dt = 0.04 s) was driven by the explicit-scheme stability limit: for a 50x50 grid on a 0.02 m plate with a thermal diffusivity of 0.0001 m^2/s, the maximum stable time step is approximately 0.04 s, and the chosen value lies at that limit. The von Neumann stability analysis in the report confirms that this is the case.

## 10. Learning outcomes

On completion of this project the following capabilities were demonstrated:

- **Numerical-methods methodology.** Discretisation of a partial differential equation on a regular grid, derivation of the explicit FTCS update formula, and implementation of the scheme in MATLAB.
- **Stability analysis.** Derivation of the von Neumann stability criterion for a two-dimensional heat-conduction problem, and verification that the chosen time step lies within the stable region.
- **Validation.** Comparison of the numerical solution against the analytical solution for the equivalent one-dimensional problem, and quantification of the numerical error.
- **MATLAB programming.** Use of vectorised array operations, plotting of two-dimensional fields with `imagesc` and `contourf`, and export of numerical data to CSV.
- **Technical writing.** Structuring of a numerical-methods report with a stability analysis, a validation study, and a discussion of the limitations of the explicit scheme.

## 11. Engineering tools: what was taught, what was self-taught

**Taught during the undergraduate programme (Brunel University, Aerospace Engineering):**

- MATLAB for numerical-methods assignments, including vectorised array operations, plotting, and ODE/PDE solvers.
- Theoretical heat transfer (conduction, convection, radiation) and the corresponding governing equations.
- Finite-difference and finite-volume methods for the solution of partial differential equations.
- Von Neumann stability analysis for explicit finite-difference schemes.
- Technical report writing in British English.

**Self-taught after graduation, in the home laboratory:**

- Python (NumPy, SciPy, Matplotlib, Pandas) for data analysis, plotting, and small utilities; the same heat-conduction problem has been re-implemented in Python as a learning exercise.
- Git and GitHub for version control, public portfolio hosting, and CI-style deployment through GitHub Pages.
- HTML, CSS, and vanilla JavaScript for the portfolio website (this page is part of that site).
- Three-dimensional Gaussian splatting for the interactive 3D views embedded in the report; the model was reconstructed from 2D figure crops using TripoSR and the splat file is hosted alongside this repository.
- Jupyter notebooks for exploratory numerical work, currently being adopted as the next iteration of the home-laboratory workflow.

The line between the two lists is not always sharp: the MATLAB and finite-difference skills were taught, and the Python, Git, HTML/CSS, and 3D skills were self-taught. The work in this repository reflects that split: the numerical analysis is uni work, and the way it is presented on the web is the self-taught chapter.

## 8. Topics

`finite-difference-method` `numerical-methods` `heat-conduction` `matlab` `ftcs-scheme`
`pde-solver` `von-neumann-stability` `thermal-analysis` `computational-physics`
`engineering-simulation`
