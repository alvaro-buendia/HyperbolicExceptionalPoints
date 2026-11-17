# HyperbolicEPs

Code to reproduce the figures of the article *"Spatial exceptional points induced by hyperbolicity in an electrostatic spherical shell"* by Á. Buendía, M. S. Barreiro and N. M. R. Peres.

This guide explains how to set up the Julia environment and run the scripts that generate the figures stored in `results/`.

## 📁 Project structure

*   **`src/`**: core physics, in the quasi-static (dipole, l = 1) approximation.
    *   `parameters.jl`: physical constants, permittivities, radii and Lorentzian parameters used in the paper.
    *   `coefficients.jl`: exponents of the potential in the shell, Eq. (5), and the amplitudes of the potential, Eq. (6), including the exceptional point.
    *   `electricfield.jl`: radial and polar components of the electric field, Eqs. (7)–(8), and maps of |E|.
    *   `extinction.jl`: Lorentzian permittivity of the shell, Eq. (11), polarizability with radiative correction, and extinction cross section.
*   **`scripts/`**: scripts that generate the figures using the source code.
    *   `Fig1c.jl`: Figure 1(c), exponents of the field as a function of ε<sub>t</sub>/ε<sub>r</sub>.
    *   `Fig2.jl`: Figure 2, exponents of the Lorentzian shell, extinction map and field profiles at the resonances.
    *   `run_all.jl`: runs all the figure scripts.
*   **`results/`**: output directory where the generated figures (PDF) are saved.
*   **`Project.toml` / `Manifest.toml`**: exact environment and dependencies (generated with Julia 1.13.3).

The derivation of all the expressions is given in the Supplemental Material of the article.

## 🚀 How to run

### 1. Prerequisites

Install [Julia](https://julialang.org) and open a terminal in the project root folder.

### 2. Instantiate the environment

Install the packages defined in the project files:

```bash
julia --project=. -e 'using Pkg; Pkg.instantiate()'
```

### 3. Generate the figures

Each figure can be generated independently:

```bash
julia --project=. scripts/Fig1c.jl
julia --project=. scripts/Fig2.jl
```

or all at once:

```bash
julia --project=. scripts/run_all.jl
```

The figures are saved in `results/`.

## Citation

If you use this code, please cite the article and the archived version of this repository: [doi:10.5281/zenodo.22078955](https://doi.org/10.5281/zenodo.22078955).

## License

MIT License (see `LICENSE`).
