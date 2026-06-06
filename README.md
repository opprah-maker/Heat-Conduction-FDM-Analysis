# 2D Heat Conduction : Finite Difference Method (MATLAB)

> Transient 2D heat conduction on a square plate solved with the explicit Forward-Time
> Central-Space (FTCS) Finite Difference Method (FDM) in MATLAB. Includes a hand-written
> solver, the full numerical report, and the measured temperature distribution.

[![MATLAB](https://img.shields.io/badge/MATLAB-Orange?logo=mathworks&logoColor=white)]()
[![FDM](https://img.shields.io/badge/Scheme-FTCS%20explicit-blue)]()
[![Report PDF](https://img.shields.io/badge/Report-PDF-red?logo=adobe-acrobat-reader&logoColor=white)]()

[![Open in MATLAB Online](https://www.mathworks.com/images/responsive/open-in-matlab-online.svg)](https://matlab.mathworks.com/open/github/v1?repo=opprah-maker/Heat-Conduction-FDM-Analysis&file=heat_conduction_fdm.m)

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
initialised at $T_0 = 25\,^\circ\text{C}$. The solver marches forward in time until
steady state is reached.

---

## 2. Report (PDF)

| Document | File |
|---|---|
| Numerical Modelling : 2D Heat Conduction FDM | [`reports/6-Numerical-Modelling.pdf`](reports/6-Numerical-Modelling.pdf) |

---

## 3. Mathematical Model

The 2D transient heat equation on a square domain is

$$\frac{\partial T}{\partial t} = \alpha \left(\frac{\partial^2 T}{\partial x^2} + \frac{\partial^2 T}{\partial y^2}\right), \qquad \alpha = \frac{k}{\rho c_p}$$

### Discretisation (FTCS)
With uniform grid spacing $\Delta x = \Delta y = h$ and time step $\Delta t$,

$$\frac{T_{i,j}^{n+1} - T_{i,j}^{n}}{\Delta t} = \alpha \left[\frac{T_{i+1,j}^{n} - 2T_{i,j}^{n} + T_{i-1,j}^{n}}{h^2} + \frac{T_{i,j+1}^{n} - 2T_{i,j}^{n} + T_{i,j-1}^{n}}{h^2}\right]$$

Rearranged for the explicit update

$$T_{i,j}^{n+1} = T_{i,j}^{n} + r\left(T_{i+1,j}^{n} + T_{i-1,j}^{n} + T_{i,j+1}^{n} + T_{i,j-1}^{n} - 4T_{i,j}^{n}\right), \qquad r = \frac{\alpha \Delta t}{h^2}$$

### Stability
The **von Neumann stability** requirement for the explicit FTCS scheme on a 2D uniform grid
is

$$r = \frac{\alpha \Delta t}{h^2} \le \frac{1}{4} \quad \Longrightarrow \quad \Delta t \le \frac{h^2}{4\alpha} = 0.25\,\text{s}$$

The solver computes this limit at run-time and prints a warning if the user-supplied
$\Delta t$ violates it.

### Boundary Conditions
| Edge | Temperature |
|---|---|
| Left ($x=0$) | $T_L = 100\,^\circ\text{C}$ |
| Right ($x=L$) | $T_R = 50\,^\circ\text{C}$ |
| Top ($y=L$) | $T_T = 75\,^\circ\text{C}$ |
| Bottom ($y=0$) | $T_B = 25\,^\circ\text{C}$ |

---

## 4. Code

| File | Purpose |
|---|---|
| [`heat_conduction_fdm.m`](heat_conduction_fdm.m) | Main solver: builds the grid, applies Dirichlet BCs, marches in time with the FTCS update, writes `heat_distribution_results.csv` and renders the steady-state contour |
| [`heat_distribution_results.csv`](heat_distribution_results.csv) | Steady-state temperature on the $11 \times 11$ grid (rows = $y$ index, columns = $x$ index) |
| [`heat-map.jpg`](heat-map.jpg) | Photograph of the original contour plot printed at submission |

---

## 5. Key Results

| Metric | Value |
|---|---|
| Grid resolution | $11 \times 11$ |
| Time step | $\Delta t = 0.25\,\text{s}$ |
| Steady-state time | $t_\infty \approx 1{,}500\,\text{s}$ |
| Centre temperature | $T(0,0) \approx 47.7\,^\circ\text{C}$ |
| Peak gradient corner | $\nabla T \approx 12.5\,^\circ\text{C/unit length}$ |

---

## 6. Figure Reference &amp; Captions

All 16 figures from the heat conduction FDM report. Each is linked to its file in `images/`.

| Fig. | Preview | Description |
|---|---|---|
| 1 | <a href="images/figure-01.png"><img src="images/figure-01.png" width="120" alt="Figure 1"></a> | Problem setup — square plate with four Dirichlet boundary temperatures and interior initial condition |
| 2 | <a href="images/figure-02.png"><img src="images/figure-02.png" width="120" alt="Figure 2"></a> | Initial temperature distribution — uniform T0 = 25 C at t = 0 |
| 3 | <a href="images/figure-03.png"><img src="images/figure-03.png" width="120" alt="Figure 3"></a> | Mesh grid — 11 x 11 uniform spatial grid on [0,1]^2 |
| 4 | <a href="images/figure-04.png"><img src="images/figure-04.png" width="120" alt="Figure 4"></a> | Boundary conditions — TL = 100 C, TR = 50 C, TT = 75 C, TB = 25 C |
| 5 | <a href="images/figure-05.png"><img src="images/figure-05.png" width="120" alt="Figure 5"></a> | Temperature evolution at t = 100 s — contour plot showing heat diffusion from boundaries |
| 6 | <a href="images/figure-06.png"><img src="images/figure-06.png" width="120" alt="Figure 6"></a> | Temperature evolution at t = 300 s — continued diffusion toward steady state |
| 7 | <a href="images/figure-07.png"><img src="images/figure-07.png" width="120" alt="Figure 7"></a> | Temperature evolution at t = 500 s — approaching steady state |
| 8 | <a href="images/figure-08.png"><img src="images/figure-08.png" width="120" alt="Figure 8"></a> | Temperature evolution at t = 1000 s — near steady state |
| 9 | <a href="images/figure-09.png"><img src="images/figure-09.png" width="120" alt="Figure 9"></a> | Steady-state temperature contour — final temperature distribution on the plate |
| 10 | <a href="images/figure-10.png"><img src="images/figure-10.png" width="120" alt="Figure 10"></a> | Steady-state temperature surface — 3D view of the temperature field |
| 11 | <a href="images/figure-11.png"><img src="images/figure-11.png" width="120" alt="Figure 11"></a> | Centre temperature vs. time — T(0,0) converging to 47.7 C |
| 12 | <a href="images/figure-12.png"><img src="images/figure-12.png" width="120" alt="Figure 12"></a> | Corner temperatures vs. time — convergence to boundary-influenced values |
| 13 | <a href="images/figure-13.png"><img src="images/figure-13.png" width="120" alt="Figure 13"></a> | Convergence history — max |T^{n+1} - T^n| vs. iteration count |
| 14 | <a href="images/figure-14.png"><img src="images/figure-14.png" width="120" alt="Figure 14"></a> | Von Neumann stability check — r = alpha dt / h^2 vs. critical value 0.25 |
| 15 | <a href="images/figure-15.png"><img src="images/figure-15.png" width="120" alt="Figure 15"></a> | Mesh refinement study — solution convergence with grid refinement |
| 16 | <a href="images/figure-16.png"><img src="images/figure-16.png" width="120" alt="Figure 16"></a> | Comparison with analytical solution — steady-state error vs. grid spacing |

---

## 7. How to Run

### 7.1 Requirements
- MATLAB R2018a or later **OR** GNU Octave 5.x or later

### 7.2 Run the solver
```matlab
% From the repository root
heat_conduction_fdm
```
The script will:
1. Build an $11 \times 11$ spatial grid on $[0,1]^2$
2. Apply the four Dirichlet boundary temperatures
3. March in time with the FTCS update until $|T^{n+1} - T^n|_\infty < 10^{-3}$
4. Write the steady-state field to `heat_distribution_results.csv`
5. Plot the steady-state temperature contour (matches `images/`)

### 7.3 Verify the stability criterion
Inside the script, the line
```matlab
dt_max = h^2 / (4 * alpha);
assert(dt <= dt_max, 'FTCS stability violated');
```
enforces the von Neumann condition. If you change $h$ or $\alpha$, this guard will fail
before the time loop starts.

---

## 8. Topics

`finite-difference-method` `numerical-methods` `heat-conduction` `matlab` `ftcs-scheme`
`pde-solver` `von-neumann-stability` `thermal-analysis` `computational-physics`
`engineering-simulation`
