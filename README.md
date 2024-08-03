# Stochastic-PGG
Code for "Evolutionary dynamics in stochastic nonlinear public goods games"

This repository includes code for performing evolutionary dynamics analysis and plotting figures. We use **MatlabR2020a** for evolutionary dynamics and figure plotting, and **Python 3.9** for Monte Carlo simulations of well-mixed and structured populations.

## Contents

- **find_zero_xxx.m**:  
  Used to calculate the internal equilibrium point.

- **x_dot_well.m**:  
  Handles evolutionary dynamics in well-mixed populations. This script generates **Figure 2**.

- **plot_r_delta_xxx.m**:  
  Plots the equilibrium fraction of cooperators \(x^*\) as a function of \(r\) for different values of \(\delta\). Generates **Figure 3**.

- **plot_p_r_xxx.m**:  
  Generates phase diagrams of the \(r-p\) parameter plane using data from `p_r_xxx.mat`. This script creates **Figure 4 a d**.

- **plot_simu_theo_xxx.m**:  
  Compares simulation results with theoretical results when \(p \in [0,1]\) in both well-mixed and structured populations. This script is responsible for **Figure 4 c f**.

- **plot_G_pxxx.m**:  
  Discusses evolutionary dynamics for different group sizes \(G\) (for well-mixed populations) or \(k+1\) (for structured populations) when \(p=0.3\) and \(p=0.6\). Generates **Figure 5**.

- **Simulation_xxx.py**:  
  Conducts Monte Carlo simulations with a single set of parameters. The output data are used to generate **Figure 4 b e** and **Figure S3**.

- **plot_figure_S1.m, plot_figure_S2c.m, plot_figure_S2d.m**:  
   Generate phase diagrams of the \(\delta_1-\delta_2\) parameter plane in Figure S1;  Generate Figure S2 c and d.
