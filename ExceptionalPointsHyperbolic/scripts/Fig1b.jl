# This script reproduces Figure 1(b) from the article

println("Generating Figure 1(b)...")

# ----------------------
# Environment setup
# ----------------------
using Pkg

project_root = joinpath(@__DIR__, "..")
Pkg.activate(project_root)
Pkg.instantiate()

# ----------------------
# Load packages
# ----------------------
using Plots
using LaTeXStrings
using ProgressMeter
using LinearAlgebra
using Measures

# ----------------------
# Paths
# ----------------------
src_path = joinpath(project_root, "src")
results_path = joinpath(project_root, "results")
mkpath(results_path)

include(joinpath(src_path,"coefficients.jl"))
include(joinpath(src_path,"parameters.jl"))

# Minimum value, maximum value and step of epsilon_t in Fig 1b.
etmin = -4;
etmax = 4;
etst = 0.01;

# Real and imaginary parts of the exponents of the electric field
Rt1 =  [real(t1(et))-1 for et in etmin:etst:etmax] # Real part  of t1-1
Rt2 =  [real(t2(et))-1 for et in etmin:etst:etmax] # Real part  of t2-1
It1 =  [imag(t1(et)) for et in etmin:etst:etmax] # Imaginary part  of t1
It2 =  [imag(t2(et)) for et in etmin:etst:etmax] # Imaginary part  of t2

# Auxiliary functions to shade regions
func(x) = 100
func2(x) = -100

# Shade regions and draw boundaries
p = plot(subplot = 1, [func,func2], -100, -1/8,  fill=(0, 0.2, :yellow), label="", bottom_margin=3mm)
plot!(subplot = 1, [func,func2], -1/8, 0,  fill=(0, 0.2, :gray), label="", bottom_margin=3mm)
vline!([-1/8],ls=:dash,lw=2,  label="", c=:black, xlims=(-2,2),ylims=(-3,3))
vline!([0],ls=:dash,lw=2,  label="", c=:gray, xlims=(-2,2),ylims=(-3,3))

# Plot exponent bands 
plot!(subplot=1, [etmin:etst:etmax], Rt1,framestyle=:box, lw=3, c=:mediumpurple2,grid=false, tickfontfamily="Computer Modern", tickfontsize=15, label=L"\textrm{Re}(t_1-1)")
plot!(subplot=1, [etmin:etst:etmax], Rt2,framestyle=:box, lw=3, c=:darkgoldenrod1, grid=false, tickfontfamily="Computer Modern", tickfontsize=15, label=L"\textrm{Re}(t_2-1)")
plot!(subplot=1, [etmin:etst:etmax], It1,framestyle=:box, lw=4, ls=:dot, c=:mediumpurple2, grid=false, tickfontfamily="Computer Modern", tickfontsize=15, label=L"\textrm{Im}(t_1)")
plot!(subplot=1, [etmin:etst:etmax], It2,framestyle=:box, lw=4, ls=:dot, c=:darkgoldenrod1, grid=false, tickfontfamily="Computer Modern", tickfontsize=15, label=L"\textrm{Im}(t_2)")

# Add Labels
plot!(legendfontsize=15, legend=(0.3,0.9), xlabel=L"\varepsilon_t/\varepsilon_r", guidefontsize=15, ylims=(-4,4), legend_columns=2)

# Save Figure

savefig(p, joinpath(results_path, "Fig1b.pdf"))

println("Figure 1(b) saved.")