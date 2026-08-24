# This script reproduces Figure S1 from the Supplemental material

println("Generating Figure S1...")

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

# Lorentzian function for the permittivity

einf = 1;
f = 1;
w0 = 2;
Lor(w) = einf + f*w0^2/(w0^2-w^2)

# Minimum, step and maximum frequency
wmin = 1;
wst = 0.01;
wmax  = 3;

# Plot figure S1(I) (type I)

# Frequency of the exceptional point (Type-I)
wEPI = sqrt((9*einf+f)/(9*einf))*w0

# As we fixed er previously, and the exponents only depend on er/et, instead of er=Lor(w) we fix et =1/Lor(w)
Rt1I =  [real(t1(1/Lor(w)))-1 for w in wmin:wst:wmax] # Real part  of t1-1
Rt2I =  [real(t2(1/Lor(w)))-1 for w in wmin:wst:wmax] # Real part  of t2-1
It1I =  [imag(t1(1/Lor(w))) for w in wmin:wst:wmax] # Imaginary part  of t1
It2I =  [imag(t2(1/Lor(w))) for w in wmin:wst:wmax] # Imaginary part  of t2

# Auxiliary functions to shade regions
func(x) = 100
 func2(x) = -100


# Shade regions and draw boundaries
pI = plot(subplot = 1, [func,func2], 2, wEPI,  fill=(0, 0.2, :gray), label="", bottom_margin=3mm)
plot!(subplot = 1, [func,func2], wEPI, 2*sqrt(2),  fill=(0, 0.2, :yellow), label="", bottom_margin=3mm)
vline!([wEPI],ls=:dash,lw=2,  label="", c=:black, xlims=(1,3))
vline!([2,sqrt(2)*2],ls=:dash,lw=2,  label="", c=:gray, xlims=(1,3))

# Plot exponent bands
plot!(subplot=1, [wmin:wst:wmax], Rt1I,framestyle=:box, lw=3, c=:mediumpurple2,grid=false, tickfontfamily="Computer Modern", tickfontsize=15, label=L"\textrm{Re}(t_1-1)")
plot!(subplot=1, [wmin:wst:wmax], Rt2I,framestyle=:box, lw=3, c=:darkgoldenrod1, grid=false, tickfontfamily="Computer Modern", tickfontsize=15, label=L"\textrm{Re}(t_2-1)")
plot!(subplot=1, [wmin:wst:wmax], It1I,framestyle=:box, lw=4, ls=:dot, c=:mediumpurple2, grid=false, tickfontfamily="Computer Modern", tickfontsize=15, label=L"\textrm{Im}(t_1)")
plot!(subplot=1, [wmin:wst:wmax], It2I,framestyle=:box, lw=4, ls=:dot, c=:darkgoldenrod1, grid=false, tickfontfamily="Computer Modern", tickfontsize=15, label=L"\textrm{Im}(t_2)")

# Plot labels, etc
plot!(legendfontsize=15, legend=(0.3,0.9), xlabel=L"\hbar\omega (eV)", guidefontsize=15, ylims=(-5,5), legend_columns=2,right_margin=2mm)
annotate!([1.1],[4.5],L"(I)")
annotate!([1.5],[-3],L"\textrm{Elliptic}")
annotate!([2.45],[-3],L"\textrm{Hyperbolic}")
annotate!([2.45],[-3.5],L"\textrm{underdamped}")
annotate!([2.05],[2],L"\textrm{Hyperbolic}")
annotate!([2.05],[1.5],L"\textrm{overdamped}")

savefig(pI, joinpath(results_path, "FigS1I.pdf"))
println("Figure S1(I) saved.")

# Plot figure S1(II) (Type-II)

# Frequency of the exceptional point (Type-iI)
wEPII = sqrt((9*einf+8f)/(9*einf))*w0


# Compute exponent bands
Rt1II =  [real(t1(Lor(w)))-1 for w in wmin:wst:wmax] # Real part  of t1-1
Rt2II =  [real(t2(Lor(w)))-1 for w in wmin:wst:wmax] # Real part  of t2-1
It1II =  [imag(t1(Lor(w))) for w in wmin:wst:wmax] # Imaginary part  of t1
It2II =  [imag(t2(Lor(w))) for w in wmin:wst:wmax] # Imaginary part  of t2

# Shade regions and draw boundaries
pII = plot(subplot = 1, [func,func2], 2, wEPII,  fill=(0, 0.2, :yellow), label="", bottom_margin=3mm)
plot!(subplot = 1, [func,func2], wEPII, 2*sqrt(2),  fill=(0, 0.2, :gray), label="", bottom_margin=3mm)
vline!([wEPII],ls=:dash,lw=2,  label="", c=:black, xlims=(1,3))
vline!([2,sqrt(2)*2],ls=:dash,lw=2,  label="", c=:gray, xlims=(1,3))

# Plot exponent bands
plot!(subplot=1, [wmin:wst:wmax], Rt1II,framestyle=:box, lw=3, c=:mediumpurple2,grid=false, tickfontfamily="Computer Modern", tickfontsize=15, label=L"\textrm{Re}(t_1-1)")
plot!(subplot=1, [wmin:wst:wmax], Rt2II,framestyle=:box, lw=3, c=:darkgoldenrod1, grid=false, tickfontfamily="Computer Modern", tickfontsize=15, label=L"\textrm{Re}(t_2-1)")
plot!(subplot=1, [wmin:wst:wmax], It1II,framestyle=:box, lw=4, ls=:dot, c=:mediumpurple2, grid=false, tickfontfamily="Computer Modern", tickfontsize=15, label=L"\textrm{Im}(t_1)")
plot!(subplot=1, [wmin:wst:wmax], It2II,framestyle=:box, lw=4, ls=:dot, c=:darkgoldenrod1, grid=false, tickfontfamily="Computer Modern", tickfontsize=15, label=L"\textrm{Im}(t_2)")

# Plot labels, etc
plot!(legendfontsize=15, legend=(0.3,0.9), xlabel=L"\hbar\omega (eV)", guidefontsize=15, ylims=(-5,5), legend_columns=2,right_margin=2mm)
annotate!([1.1],[4.5],L"(II)")
annotate!([1.5],[-3],L"\textrm{Elliptic}")
annotate!([2.45],[-3],L"\textrm{Hyperbolic}")
annotate!([2.45],[-3.5],L"\textrm{underdamped}")
annotate!([2.75],[2],L"\textrm{Hyperbolic}")
annotate!([2.75],[1.5],L"\textrm{overdamped}")

#Save figure
savefig(pII, joinpath(results_path, "FigS1II.pdf"))
println("Figure S1(II) saved.")