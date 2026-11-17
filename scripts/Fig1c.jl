# This script reproduces Figure 1(c) of the article: real and imaginary parts
# of the field exponents t1,2 - 1 as a function of eps_t/eps_r (dipole, l = 1).

println("Generating Figure 1(c)...")

# ==================================================
# ENVIRONMENT SETUP
# ==================================================

using Pkg

project_root = joinpath(@__DIR__, "..")
Pkg.activate(project_root)
Pkg.instantiate()

# ==================================================
# LOAD PACKAGES
# ==================================================

using Plots
using LaTeXStrings
using Measures

# ==================================================
# PATHS AND SOURCE FILES
# ==================================================

src_path = joinpath(project_root, "src")
results_path = joinpath(project_root, "results")
mkpath(results_path)

include(joinpath(src_path, "coefficients.jl"))
include(joinpath(src_path, "parameters.jl"))

# ==================================================
# EXPONENTS
# ==================================================

# Minimum value, maximum value and step of eps_t (eps_r = 1)
etmin = -4
etmax = 4
etst = 0.01

# Real and imaginary parts of the exponents of the electric field
Rt1 = [real(t1(et)) - 1 for et in etmin:etst:etmax]   # Re(t1 - 1)
Rt2 = [real(t2(et)) - 1 for et in etmin:etst:etmax]   # Re(t2 - 1)
It1 = [imag(t1(et)) for et in etmin:etst:etmax]       # Im(t1)
It2 = [imag(t2(et)) for et in etmin:etst:etmax]       # Im(t2)

# ==================================================
# PLOT
# ==================================================

# Auxiliary functions to shade regions
func(x) = 100
func2(x) = -100

# Shade the underdamped (yellow) and overdamped (gray) hyperbolic regions and
# mark the EP (black dashed line) and the hyperbolic-elliptic boundary (gray)
p = plot(subplot = 1, [func, func2], -100, -1/8, fill = (0, 0.1, :yellow), label = "", bottom_margin = 3mm)
plot!(subplot = 1, [func, func2], -1/8, 0, fill = (0, 0.16, :gray), label = "", bottom_margin = 3mm)
vline!([-1/8], ls = :dash, lw = 2, label = "", c = :black, xlims = (-2, 2), ylims = (-3, 3))
vline!([0], ls = :dash, lw = 2, label = "", c = :gray, xlims = (-2, 2), ylims = (-3, 3))

# Exponent branches
plot!(subplot = 1, [etmin:etst:etmax], Rt1, framestyle = :box, lw = 3, c = :mediumpurple2, grid = false, tickfontfamily = "Computer Modern", tickfontsize = 15, label = L"\textrm{Re}(t_1-1)")
plot!(subplot = 1, [etmin:etst:etmax], Rt2, framestyle = :box, lw = 3, c = :darkgoldenrod1, grid = false, tickfontfamily = "Computer Modern", tickfontsize = 15, label = L"\textrm{Re}(t_2-1)")
plot!(subplot = 1, [etmin:etst:etmax], It1, framestyle = :box, lw = 4, ls = :dot, c = :mediumpurple2, grid = false, tickfontfamily = "Computer Modern", tickfontsize = 15, label = L"\textrm{Im}(t_1)")
plot!(subplot = 1, [etmin:etst:etmax], It2, framestyle = :box, lw = 4, ls = :dot, c = :darkgoldenrod1, grid = false, tickfontfamily = "Computer Modern", tickfontsize = 15, label = L"\textrm{Im}(t_2)")

# Region labels (i)-(iv) and arrows pointing to the EP and the overdamped region
annotate!([-1.7, -0.25, 0.25, 1.7], [-3, -3, -3, -3], [L"\textit{(i)}", L"\textit{(ii)}", L"\textit{(iii)}", L"\textit{(iv)}"])
plot!([0.1, -1/16], [-3, -3], arrow = :true, c = :black, label = "", lw = 2)
plot!([-0.25, -1/8], [-2.7, -2.2], arrow = :true, label = "", c = :black, lw = 2)

# Axis label, limits and legend
plot!(legendfontsize = 15, legend = (0.3, 0.9), xlabel = L"\varepsilon_t/\varepsilon_r", guidefontsize = 15, ylims = (-4, 4), legend_columns = 2)

# ==================================================
# SAVE FIGURE
# ==================================================

savefig(p, joinpath(results_path, "Fig1c.pdf"))

println("Figure 1(c) saved.")
