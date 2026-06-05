# 2D Transient Heat Conduction Simulation using Finite Difference Method (FDM)

This repository contains a MATLAB script that performs a 2D transient heat conduction simulation on a square plate using the Finite Difference Method (FDM) with an explicit time-stepping scheme.

---

## 📐 Numerical Formulation

### 1. Governing Partial Differential Equation
The physics of two-dimensional heat conduction in an isotropic solid is governed by the transient heat equation:
$$\frac{\partial T}{\partial t} = \alpha \left( \frac{\partial^2 T}{\partial x^2} + \frac{\partial^2 T}{\partial y^2} \right)$$

Where:
* $T(x,y,t)$ is the temperature field.
* $\alpha$ is the thermal diffusivity ($1.0 \times 10^{-4} \text{ m}^2/\text{s}$).

### 2. Discretization Scheme
Applying the **Forward-Time Central-Space (FTCS)** explicit finite difference formulation:
* First-order forward difference in time:
  $$\frac{\partial T}{\partial t} \approx \frac{T_{i,j}^{n+1} - T_{i,j}^n}{\Delta t}$$
* Second-order central difference in space:
  $$\frac{\partial^2 T}{\partial x^2} \approx \frac{T_{i+1,j}^n - 2T_{i,j}^n + T_{i-1,j}^n}{\Delta x^2}, \quad \frac{\partial^2 T}{\partial y^2} \approx \frac{T_{i,j+1}^n - 2T_{i,j}^n + T_{i,j-1}^n}{\Delta y^2}$$

Substituting these approximations yields the explicit updating equation for the temperature field:
$$T_{i,j}^{n+1} = T_{i,j}^n + \alpha \Delta t \left[ \frac{T_{i+1,j}^n - 2T_{i,j}^n + T_{i-1,j}^n}{\Delta x^2} + \frac{T_{i,j+1}^n - 2T_{i,j}^n + T_{i,j-1}^n}{\Delta y^2} \right]$$

### 3. Numerical Stability Criteria
For the explicit FTCS scheme to be stable, the time step must satisfy the **von Neumann stability constraint**:
$$\Delta t \le \frac{\min(\Delta x, \Delta y)^2}{4\alpha}$$

Given:
* $\Delta x = \Delta y = 0.01\text{ m}$
* $\alpha = 1.0 \times 10^{-4} \text{ m}^2/\text{s}$

The stability limit is:
$$\Delta t_{\text{limit}} = \frac{(0.01)^2}{4 \times 1e-4} = 0.25\text{ s}$$

Since the code uses $\Delta t = 0.001\text{ s}$, the simulation is highly stable (Safety Factor $SF = 250$).

---

## 🎯 Simulation Parameters
* **Grid Spacing ($\Delta x, \Delta y$)**: $0.01\text{ m}$
* **Plate Dimensions**: $0.1\text{ m} \times 0.1\text{ m}$
* **Grid Resolution**: $11 \times 11$ points
* **Max Simulation Time ($T_{\text{max}}$)**: $1.0\text{ s}$
* **Boundary Conditions (Dirichlet)**:
  * Left Boundary: $T(0,y,t) = 100^\circ\text{C}$
  * Right Boundary: $T(L_x,y,t) = 50^\circ\text{C}$
  * Top Boundary: $T(x,L_y,t) = 75^\circ\text{C}$
  * Bottom Boundary: $T(x,0,t) = 25^\circ\text{C}$

---

## 📁 Repository Contents
* `heat_conduction_fdm.m`: MATLAB simulation script.
* `heat_distribution_results.csv`: Saved CSV file containing the final temperature distribution grid.
* `heat-map.jpg`: Plotted 2D temperature contour.
