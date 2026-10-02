# Dual-Channel Competition Framework

MATLAB codes accompanying the manuscript:

> **A Dual-Channel Competition Framework Reveals Hidden Hydraulic State Transitions**  
> Huayang Cai, Gaojin Li, Ping Zhang, Jianliang Lin, Tongtiegang Zhao, and Kairong Lin

## Overview

This repository contains seven MATLAB scripts associated with the principal figures of the manuscript *A Dual-Channel Competition Framework Reveals Hidden Hydraulic State Transitions*.

The study develops a dual-channel competition framework for resolving two physically defined, nonnegative contributions that act in opposite directions on a specified hydraulic response. The framework is applied to steady, fully developed Newtonian laminar flow in a partially filled circular conduit.

For the conduit problem, the physical velocity is decomposed as

**U<sub>FS</sub> = U<sub>D</sub> + U<sub>C</sub> + U<sub>R</sub>**

where U<sub>D</sub> is the filling-dependent Poisson driving field, U<sub>C</sub> represents rigid-chord confinement, and U<sub>R</sub> represents free-surface release.

The opposing confinement and release contributions are represented as two nonnegative channels. This construction provides diagnostics for mechanism dominance, simultaneous activity, cancellation, and hydraulic state transitions that cannot be identified from total discharge alone.

## Repository Contents

| File | Description |
| --- | --- |
| `fig1.m` | **Dual-channel competition geometry.** Illustrates two opposing nonnegative channels, representative competition states, the dimensional state representation, and the normalized unit-semicircle representation. |
| `fig2.m` | **Circular-conduit geometry and boundary conditions.** Draws the partially filled circular conduit, filling depth, pipe radius, filling angle, no-slip pipe wall, and shear-free surface. |
| `fig3.m` | **Mechanism-resolved velocity fields.** Evaluates the physical velocity, Poisson driving field, confinement magnitude, and free-surface release magnitude at representative filling ratios H = 0.30, 1.00, and 1.80. |
| `fig4.m` | **Integrated boundary competition.** Computes the confinement and release contributions, their signed difference, normalized dominance and interaction variables, and the corresponding trajectory on the unit semicircle. |
| `fig5.m` | **Hydraulic performance diagnostics.** Evaluates the physical discharge and two cancellation-adjusted diagnostics and determines their characteristic maximum states. |
| `fig6.m` | **Equal-discharge hydraulic states.** Identifies two filling ratios with the same physical discharge and compares their velocity fields, wall-shear distributions, and driving-confinement-release contributions. |
| `fig7.m` | **Analytical comparison across canonical flows.** Compares the normalized dual-channel competition structure for plane Couette-Poiseuille flow, an opposing-shear Nusselt film, and the partially filled circular-conduit boundary subsystem. |

## Dual-Channel Competition Variables

For two nonnegative competing channels J<sub>+</sub> and J<sub>−</sub>, define the total activity

**𝒩 = J<sub>+</sub> + J<sub>−</sub>**

the signed dominance

**S = J<sub>+</sub> − J<sub>−</sub>**

and the interaction magnitude

**M = 2√(J<sub>+</sub>J<sub>−</sub>)**

These quantities satisfy the exact identity

**𝒩² − S² = M²**

For 𝒩 > 0, define the normalized variables

**β = S / 𝒩**

**m = M / 𝒩**

which satisfy

**β² + m² = 1**

Thus, all nontrivial normalized competition states lie on the upper unit semicircle.

For the partially filled circular conduit, the two integrated boundary channels are the release contribution R<sub>Q</sub> and confinement contribution C<sub>Q</sub>:

**J<sub>+</sub> = R<sub>Q</sub>**

**J<sub>−</sub> = C<sub>Q</sub>**

Therefore, the signed boundary correction is

**S<sub>B</sub> = R<sub>Q</sub> − C<sub>Q</sub>**

At half filling (H = 1), the two boundary contributions are equal and finite. Hence,

**S<sub>B</sub> = 0, &nbsp;&nbsp; β<sub>B</sub> = 0, &nbsp;&nbsp; m<sub>B</sub> = 1**

This represents a balanced-active boundary state rather than an inactive state.

## Representative Hydraulic States

The scripts use three representative filling ratios to illustrate the transition from confinement dominance to release dominance:

| State | Filling ratio | Interpretation |
| --- | ---: | --- |
| I | H = 0.30 | Confinement-dominated boundary state |
| II | H = 1.00 | Balanced-active boundary state |
| III | H = 1.80 | Release-dominated boundary state |

## Characteristic Filling States

The calculations distinguish several characteristic states:

- exact boundary-mechanism balance at **H = 1**;
- maximum physical discharge at approximately **H = 1.723**;
- maximum boundary cancellation-adjusted diagnostic at approximately **H = 1.735**;
- maximum whole-transport cancellation-adjusted diagnostic at approximately **H = 1.811**.

The three maximum states are evaluated independently in `fig5.m` using the corresponding scalar expressions and one-dimensional numerical optimization.

## Equal-Discharge Example

`fig6.m` illustrates that total discharge does not uniquely determine the internal hydraulic state.

The script uses a target discharge equal to **0.95 Q<sub>FS,max</sub>** and determines two filling states on opposite sides of the maximum-discharge state:

**H<sub>1</sub> = 1.5663, &nbsp;&nbsp; H<sub>2</sub> = 1.8617**

with the same physical discharge,

**Q<sub>FS</sub> ≈ 0.47502**

Although the integrated discharge is the same, the two states exhibit different velocity fields, wall-shear distributions, and driving-confinement-release contributions.

## Requirements

- MATLAB R2019b or later
- Standard MATLAB numerical and graphics functions
- No third-party packages

## Usage

Clone or download the repository and set the repository directory as the current MATLAB working directory.

Run an individual script directly in MATLAB. For example:

```matlab
fig1
```

The remaining scripts can be run in the same way:

```matlab
fig2
fig3
fig4
fig5
fig6
fig7
```

Each script contains the calculations and helper functions required for its corresponding analysis and visualization.

## Numerical Implementation

Depending on the figure, the scripts use exact analytical expressions together with numerical quadrature, one-dimensional optimization, root finding, velocity-field evaluation, wall-shear evaluation, and internal consistency checks.

The scripts are organized for direct figure reproduction rather than as a general-purpose MATLAB package. Parameters, numerical tolerances, plotting settings, and local helper functions are therefore retained within the corresponding scripts.

Minor differences in figure appearance may occur between MATLAB releases because of graphics rendering, fonts, and operating-system settings.

## Citation

If you use these codes or the dual-channel competition framework in academic work, please cite the accompanying manuscript:

> Cai, H., Li, G., Zhang, P., Lin, J., Zhao, T., and Lin, K.  
> **A Dual-Channel Competition Framework Reveals Hidden Hydraulic State Transitions.**

Full bibliographic information and the DOI will be added after publication.

## Code Availability

The MATLAB scripts in this repository provide the analytical and numerical procedures used to generate the principal results and figures described above. No external experimental dataset is required to execute these figure-generation scripts.

## Contact

For questions regarding the manuscript or MATLAB implementation, please contact:

**Huayang Cai**  
Institute of Estuarine and Coastal Research  
School of Ocean Engineering and Technology  
Sun Yat-sen University  
Zhuhai, Guangdong, China  

Email: caihy7@mail.sysu.edu.cn
