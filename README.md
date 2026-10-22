This repository contains the simulation framework, control algorithms, parameter derivation scripts, and 3D visualization scripts for a Dual-Motor All-Wheel Drive (AWD) Electric Tractor adapted from the Massey Ferguson 375 (MF375) platform. 

The system replaces the mechanical inter-axle differential with independent front and rear 15 kW Permanent Magnet Synchronous Motors (PMSMs).
Torque allocation is governed dynamically by a 25-rule Mamdani Fuzzy Logic Controller (FLC) based on instantaneous speed error and load change rate, evaluated across five distinct agricultural operating modes representative of Nigerian and tropical field conditions.

## Overview

This project models and simulates a dual-motor all-wheel-drive (AWD) electric tractor drivetrain derived from the Massey Ferguson 375 — Nigeria's most common diesel
tractor. The diesel powertrain is replaced with:

- Two × 15 kW Permanent Magnet Synchronous Motors (PMSM)
- A 96 V / 100 Ah lithium-ion battery pack
- A Mamdani fuzzy logic torque distribution controller that replaces the
  mechanical inter-axle differential entirely in software
- A shared PID speed controller tuned using the Ziegler-Nichols method

The simulation evaluates drivetrain performance across five Nigerian agricultural operating modes: plowing, harrowing, ridging, planting/sowing, and transportation.

The primary output is the first simulation-based Wh/km energy consumption benchmark for a dual-motor electric tractor evaluated specifically under Nigerian soil and terrain conditions.


---

## Requirements

### Software
- **MATLAB R2021b or later** (tested and developed on R2024b)
- **Simulink**
- **Fuzzy Logic Toolbox**
- **Control System Toolbox**
- 

### Check your toolboxes
```matlab
% Run in MATLAB Command Window to verify all required toolboxes

## Getting Started

### 1. Clone the repository
```bash
git clone https://github.com/kenny214-apple/electric-tractor-fyp.git
cd electric-tractor-fyp
```

### 2. Open MATLAB and set path
```matlab
% Add all project folders to MATLAB path
addpath(genpath('electric-tractor-fyp'));
```

### 3. Open the Simulink model
```matlab
open('simulation/electric_tractor.slx')
```

---

## How to Run

### Run a single operating mode

```matlab
% Set your operating mode:
%   MODE = 1  →  Plowing       (0.833 m/s, μ_rr = 0.25, slope = 5°)
%   MODE = 2  →  Harrowing     (1.111 m/s, μ_rr = 0.20, slope = 5°)
%   MODE = 3  →  Ridging       (1.111 m/s, μ_rr = 0.22, slope = 5°)
%   MODE = 4  →  Planting      (0.694 m/s, μ_rr = 0.16, slope = 0°)
%   MODE = 5  →  Transportation (3.333 m/s, μ_rr = 0.12, slope = 0°)

MODE = 1;              % Set mode
init;                  % Load all parameters into workspace
out = sim('simulation/electric_tractor');  % Run simulation

% Extract results
v_data   = out.v_sim;
SoC_data = out.SoC_sim;
TSR_data = out.TSR_sim;
T_f_data = out.T_front_sim;
T_r_data = out.T_rear_sim;
P_data   = out.P_total_sim;

% Quick result check
fprintf('Final speed  : %.4f m/s\n', v_data(end));
fprintf('SoC drop     : %.2f%%\n', (SoC_data(1)-SoC_data(end))*100);
fprintf('TSR steady   : %.4f\n', mean(TSR_data(end-999:end)));
fprintf('T_total      : %.2f Nm\n', T_f_data(end)+T_r_data(end));
```

### Run all five modes automatically

```matlab
run('scripts/run_all_modes.m')
```

This runs all five modes sequentially and prints a consolidated results table.

### Generate all results figures

```matlab
run('scripts/plot_results.m')
```

Generates and saves all 10 figures (Fig1–Fig10) to the `results/` folder.
---

## Expected Console Output

Running MODE = 1 (Plowing) should produce:

## Project Video
Download the file FYP Recording.mp4 to watch the full project explanation.