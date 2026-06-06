# 2D Heat Conduction : Finite Difference Method (MATLAB)

> Transient 2D heat conduction on a square plate solved with the explicit Forward-Time
> Central-Space (FTCS) Finite Difference Method (FDM) in MATLAB. Includes a hand-written
> solver, the full numerical report, and the measured temperature distribution.

[![MATLAB](https://img.shields.io/badge/MATLAB-Orange?logo=mathworks&logoColor=white)]()
[![FDM](https://img.shields.io/badge/Scheme-FTCS%20explicit-blue)]()
[![Report PDF](https://img.shields.io/badge/Report-PDF-red?logo=adobe-acrobat-reader&logoColor=white)]()

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

Plain-text extract: [`reports/6-Numerical-Modelling_text.txt`](reports/6-Numerical-Modelling_text.txt).

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

## 6. Figure Gallery

<table>
<tr><td align="center"><img src="images/figure-01.png" width="240" alt="figure-01.png"/><br/><sub>figure-01.png</sub></td><td align="center"><img src="images/figure-02.png" width="240" alt="figure-02.png"/><br/><sub>figure-02.png</sub></td><td align="center"><img src="images/figure-03.png" width="240" alt="figure-03.png"/><br/><sub>figure-03.png</sub></td><td align="center"><img src="images/figure-04.png" width="240" alt="figure-04.png"/><br/><sub>figure-04.png</sub></td></tr>
<tr><td align="center"><img src="images/figure-05.png" width="240" alt="figure-05.png"/><br/><sub>figure-05.png</sub></td><td align="center"><img src="images/figure-06.png" width="240" alt="figure-06.png"/><br/><sub>figure-06.png</sub></td><td align="center"><img src="images/figure-07.png" width="240" alt="figure-07.png"/><br/><sub>figure-07.png</sub></td><td align="center"><img src="images/figure-08.png" width="240" alt="figure-08.png"/><br/><sub>figure-08.png</sub></td></tr>
<tr><td align="center"><img src="images/figure-09.png" width="240" alt="figure-09.png"/><br/><sub>figure-09.png</sub></td><td align="center"><img src="images/figure-10.png" width="240" alt="figure-10.png"/><br/><sub>figure-10.png</sub></td><td align="center"><img src="images/figure-11.png" width="240" alt="figure-11.png"/><br/><sub>figure-11.png</sub></td><td align="center"><img src="images/figure-12.png" width="240" alt="figure-12.png"/><br/><sub>figure-12.png</sub></td></tr>
<tr><td align="center"><img src="images/figure-13.png" width="240" alt="figure-13.png"/><br/><sub>figure-13.png</sub></td><td align="center"><img src="images/figure-14.png" width="240" alt="figure-14.png"/><br/><sub>figure-14.png</sub></td><td align="center"><img src="images/figure-15.png" width="240" alt="figure-15.png"/><br/><sub>figure-15.png</sub></td><td align="center"><img src="images/figure-16.png" width="240" alt="figure-16.png"/><br/><sub>figure-16.png</sub></td></tr>
</table>

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
