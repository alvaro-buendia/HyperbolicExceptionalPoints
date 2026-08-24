# This script reproduces Figure 2 from the article

println("Generating Figure 2...")

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
include(joinpath(src_path,"electricfield.jl"))

# Define parameters of the map (minima, maxima and step in terms of a)
xmin = -1.2;
xmax = 1.2;
xst = 0.005;
ymin = -1.2;
ymax = 1.2;
yst= 0.005;

# Tangential component of the permittivity values 
et1 = -100;
et2 = -1/8;
et3 = 100;

# Compute field amplitude maps 
Emap1 =  Emap(xmin*a,xmax*a,ymin*a,ymax*a,xst*a,yst*a,et1);
Emap2 =  Emap(xmin*a,xmax*a,ymin*a,ymax*a,xst*a,yst*a,et2);
Emap3 =  Emap(xmin*a,xmax*a,ymin*a,ymax*a,xst*a,yst*a,et3);

# Maxima of the fields
max1 = maximum(Emap1);
max2 = maximum(Emap2);
max3 = maximum(Emap3);

# Plot figure 2 

# Define layout
l= @layout [grid(1,3){0.95h};grid(1,3){0.05h}]
p = plot(layout = l)

# Plot colormaps 
heatmap!(subplot=1, [xmin:xst:xmax], [ymin:yst:ymax], transpose(real(Emap1)), c=:inferno, aspect_ratio=:equal,xlims=(-1.2,1.2),top_margin = 3mm, title = L"\varepsilon_t/\varepsilon_r = -100 \; \textrm{(Underdamped) }\; ", ylims=(-1.2,1.2), colorbar=:bottom)
heatmap!(subplot=2, [xmin:xst:xmax], [ymin:yst:ymax], transpose(real(Emap2)), title = L" \varepsilon_t/\varepsilon_r  = -1/8\; \textrm{(Critically \; damped)}\;", c=:inferno, aspect_ratio=:equal, xlims=(-1.2,1.2), ylims=(-1.2,1.2))
heatmap!(subplot=3, [xmin:xst:xmax], [ymin:yst:ymax], transpose(real(Emap3)), title = L"  \varepsilon_t/\varepsilon_r  = -1/100\; \textrm{(Overdamped)}\;", c=:inferno, aspect_ratio=:equal, legend=false,xlims=(-1.2,1.2), ylims=(-1.2,1.2))
plot!(rightmargin=5mm, xlabel=L"x/a",ylabel=L"z/a")

# Plot region boundaries (r=b,a)
plot!([cos(x) for x in 0:pi/100:2pi], [sin(x) for x in 0:pi/100:2pi], c=:white, ls=:dash)
plot!([b/a*cos(x) for x in 0:pi/100:2pi], [b/a*sin(x) for x in 0:pi/100:2pi], c=:white, ls=:dash, legend=false)
plot!([cos(x) for x in 0:pi/100:2pi], [sin(x) for x in 0:pi/100:2pi], c=:white, ls=:dash,  subplot=2)
plot!([b/a*cos(x) for x in 0:pi/100:2pi], [b/a*sin(x) for x in 0:pi/100:2pi], c=:white, ls=:dash, legend=false, subplot=2)
plot!([cos(x) for x in 0:pi/100:2pi], [sin(x) for x in 0:pi/100:2pi], c=:white, ls=:dash,  subplot=3)
plot!([b/a*cos(x) for x in 0:pi/100:2pi], [b/a*sin(x) for x in 0:pi/100:2pi], c=:white, ls=:dash, legend=false, subplot=3)

# Plot colorbars
plot!(xlims=(-1.2,1.2), ylims=(-1.2,1.2), size=(1550,570),cb=false)
heatmap!(subplot = 4,  [0:0.01*max1:max1],[1:100], [x for i in 1:100, x in 0:0.01*max1:max1], c=:inferno, cbar=false, xlims=(0,max1) ,ylims=(1,100),ylabel=L"|E|/E_0",yticks=false)
heatmap!(subplot = 5,  [0:0.01*max2:max2],[1:100], [x for i in 1:100, x in 0:0.01*max2:max2], c=:inferno, cbar=false, xlims=(0,max2) ,ylims=(1,100),ylabel="",yticks=false)
heatmap!(subplot = 6,  [0:0.01*max3:max3],[1:100], [x for i in 1:100, x in 0:0.01*max3:max3], c=:inferno, cbar=false, xlims=(0,max3) ,ylims=(1,100),ylabel="",yticks=false)

# Define labels, etc.

plot!(tickfontsize=18,guidefontsize=18,titlefontsize=18, tickfontfamily="Computer Modern",guidefontfamily="Computer Modern")
plot!(subplot=1, left_margin=7mm)
plot!(subplot=2, left_margin=0mm)

# Save figure 

savefig(p, joinpath(results_path, "Fig2.pdf"))

println("Figure 2 saved.")