# This script reproduces Figure 2 of the article:
#   (a) exponents of the field for the Lorentzian shell, Eq. (11);
#   (b) extinction cross section vs photon energy and log(a/b), at fixed b;
#   (c) field maps |E|/E_max at the three resonances for a/b = 3.

println("Generating Figure 2...")

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
include(joinpath(src_path, "electricfield.jl"))
include(joinpath(src_path, "extinction.jl"))

# ==================================================
# FIGURE 2(a): EXPONENT BRANCHES
# ==================================================
einf = 1;
gamma = 0.05;
f = 1;
w0 = 2.0 ;
k(w) = w/c*sqrt(eh)

w1 = 2.415
w2 = 2.128
w3 = 2.051

wmin, wst, wmax = 1.25, 0.01, 3.25

gamma = 0.05

w = collect(wmin:wst:wmax)

Rt1I = [real(t1w(ω)) - 1 for ω in w]
Rt2I = [real(t2w(ω)) - 1 for ω in w]

It1I = [imag(t1w(ω)) for ω in w]
It2I = [imag(t2w(ω)) for ω in w]


# Reference frequencies
wEP = w0 * sqrt((9 * einf + 8 * f) / (9 * einf))
wLO = w0 * sqrt((einf + f) / einf)

c1 = :mediumpurple2
c2 = :darkgoldenrod1


common = (
    framestyle = :box,
    grid = false,
    tickfontfamily = "Computer Modern",
    tickfontsize = 9,
    guidefontfamily = "Computer Modern",
    guidefontsize = 10,
    legendfontsize = 7,
    xlims = (1, 3),
    left_margin = 4mm,
    right_margin = 2mm,
    top_margin = 1mm,
    bottom_margin = 1mm,
)

p1 = plot(;
    common...,
    ylims = (-6, 6),
    ylabel = "Exponents",
    xlabel = "",
    legend = :topright,
    legend_columns = 2,
)
plot!(
    p1, w, Rt1I;
    color = c1,
    linewidth = 1.5,
    label = L"\mathrm{Re}(t_1-1)",
)

plot!(
    p1, w, Rt2I;
    color = c2,
    linewidth = 1.5,
    label = L"\mathrm{Re}(t_2-1)",
)

plot!(
    p1, w, It1I;
    color = c1,
    linestyle = :dash,
    linewidth = 1.5,
    label = L"\mathrm{Im}(t_1)",
)

plot!(
    p1, w, It2I;
    color = c2,
    linestyle = :dash,
    linewidth = 1.5,
    label = L"\mathrm{Im}(t_2)",
)

# Reference-frequency lines
vline!(
    p1, [wEP];
    color = :black,
    linestyle = :dash,
    linewidth = 0.8,
    label = "",
)

vline!(
    p1, [w0, wLO];
    color = :black,
    linestyle = :dot,
    linewidth = 0.8,
    label = "",
)

# Regime shading
vspan!(
    p1, [w0, wEP];
    color = :yellow,
    alpha = 0.07,
    label = "",
)

vspan!(
    p1, [wEP, wLO];
    color = :grey,
    alpha = 0.12,
    label = "",
)


# ==================================================
# FIGURE 2(b): EXTINCTION CROSS SECTION
# ==================================================

gamma = 0.05 

sigma_hm = [
    sigmaext(ω, b * exp(l), b) / (4pi * (b * exp(l))^2)
    for ω in w, l in 0.1:0.01:3
]

p2 = heatmap(
    w,
    [0.1:0.01:3],
    transpose(log10.(abs.(sigma_hm)));
    ylabel = L"\log(a/b)",
    xlabel = L"\hbar\omega \;\textrm{(eV)}",
    colorbar_title = "",
    tickfontsize = 10,
    tickfontfamily = "Computer Modern",
    guidefontfamily = "Computer Modern",
    titlefontsize = 10,
    color = :inferno,
    cb = :top,
    bottom_margin = 5mm,
)

vline!([2.75]; ls = :dash, lw = 1, c = :black, legend = false)
vline!([2, 2 * sqrt(2)]; ls = :dot, lw = 1, c = :gray, legend = false)
hline!([log(3)]; ls = :dash, lw = 1, c = :white, legend = false)

annotate!(
    [w1, w2, w3],
    [1.4, 0.8, 1.4],
    [L"\hbar\omega_1", L"\hbar\omega_2", L"\hbar\omega_3"],
)

scatter!(
    [w1, w2, w3],
    [log(3), log(3), log(3)];
    c = :white,
    markerstrokewidth = -1,
    frame = :box,
    xlims = (1.75, 3),
    ylims = (0.1, 3),
    title = L"\log_\textrm{10}(\sigma_\textrm{ext}/(4\pi a^2))",
)


# ==================================================
# FIGURE 2(c): FIELD PROFILES
# ==================================================

b = 1.0e-8

w1 = 2.415
w2 = 2.128
w3 = 2.051

et1 = etw(w1)
et2 = etw(w2)
et3 = etw(w3)

# Spatial grid
xmin, xmax = -1.2, 1.2
ymin, ymax = -1.2, 1.2
xst, yst = 0.005, 0.005

xmap = collect(xmin:xst:xmax)
ymap = collect(ymin:yst:ymax)

# Electric-field maps
Emap1 = Emap(
    xmin * a, xmax * a,
    ymin * a, ymax * a,
    xst * a, yst * a,
    et1,
)

Emap2 = Emap(
    xmin * a, xmax * a,
    ymin * a, ymax * a,
    xst * a, yst * a,
    et2,
)

Emap3 = Emap(
    xmin * a, xmax * a,
    ymin * a, ymax * a,
    xst * a, yst * a,
    et3,
)

# Core and shell boundaries
θ = range(0, 2pi, length = 300)

x_outer = cos.(θ)
y_outer = sin.(θ)

x_inner = (b / a) .* cos.(θ)
y_inner = (b / a) .* sin.(θ)

# Common field-map settings
field_common = (
    c = :inferno,
    aspect_ratio = :equal,
    colorbar = false,
    axis = false,
    ticks = false,
    framestyle = :none,
    grid = false,
    xlims = (xmin, xmax),
    ylims = (ymin, ymax),
    titlefontfamily = "Computer Modern",
    titlefontsize = 10,
    margin = 0mm,
    left_margin = 0mm,
    right_margin = 0mm,
    top_margin = 1mm,
    bottom_margin = 0mm,
)

pfield1 = heatmap(
    xmap, ymap, permutedims(Emap1);
    field_common...,
    clims = (0, maximum(Emap1)),
    c = :inferno,
    title = L"\hbar\omega_1 = 2.42 \mathrm{eV}",
)

pfield2 = heatmap(
    xmap, ymap, permutedims(Emap2);
    field_common...,
    clims = (0, maximum(Emap2)),
    c = :inferno,
    title = L"\hbar\omega_2 = 2.13 \mathrm{eV}",
)

pfield3 = heatmap(
    xmap, ymap, permutedims(Emap3);
    field_common...,
    clims = (0, maximum(Emap3)),
    c = :inferno,
    title = L"\hbar\omega_3 = 2.05 \mathrm{eV}",
    xlabel = L"|E|/E_{max2}",
)

# Shell boundaries on all field maps
for pf in (pfield1, pfield2, pfield3)
    plot!(
        pf, x_outer, y_outer;
        color = :white,
        linestyle = :dash,
        linewidth = 0.9,
        label = false,
    )

    plot!(
        pf, x_inner, y_inner;
        color = :white,
        linestyle = :dash,
        linewidth = 0.9,
        label = false,
    )
end


# ==================================================
# COMPOSE FIGURE
# ==================================================

layout_final = @layout [
    a{0.38h}
    b{0.38h}
    c{0.25w} d{0.375w} e{0.375w}
]

pII = plot(
    p1, p2, pfield1, pfield2, pfield3;
    layout = layout_final,
    link = :x,
    size = (390, 690),
    margin = 0mm,
    left_margin = 4mm,
    right_margin = 2mm,
    top_margin = 1mm,
    bottom_margin = 2mm,
    plot_title = "",
)

# Field-map margins
plot!(right_margin = -4mm, left_margin = -4mm, subplot = 4)
plot!(left_margin = 2mm, right_margin = 2mm, subplot = 5)

# Axis limits and ticks
plot!(subplot = 1, xlims = (1.75, 3), xticks = (2:0.5:3))
plot!(subplot = 2, xlims = (1.75, 3), cb = false)

# Panel (a): reference-frequency annotations
annotate!(
    [w0, wLO, wEP],
    [6.75, 6.75, -6.75],
    [L"\hbar\omega_0", L"\hbar\omega_\textrm{LO}", L"\hbar\omega_\textrm{EP}"];
    subplot = 1,
    annotationfontsize = 12,
    top_margin = 5mm,
)

annotate!([1.55], [6], [L"(a)"]; subplot = 1, annotationfontsize = 12)

# Panel (b)
annotate!([1.55], [3], [L"(b)"]; subplot = 2, annotationfontsize = 12)

# Panel (c): field-map labels
annotate!([-1.45], [1.7], [L"(c)"]; subplot = 3, annotationfontsize = 12)

annotate!(
    [0], [-1.6], [L"|\textbf{E} \;|/E_\textrm{max1}"];
    subplot = 3,
    annotationfontsize = 12,
)

annotate!(
    [0], [-1.6], [L"|\textbf{E}\;|/E_\textrm{max2}"];
    subplot = 4,
    annotationfontsize = 12,
)

annotate!(
    [0], [-1.6], [L"|\textbf{E} \;|/E_\textrm{max3}"];
    subplot = 5,
    annotationfontsize = 12,
)


# ==================================================
# EXTINCTION COLORBAR INSET
# ==================================================

# Configure subplot 6 as a horizontal colorbar above subplot 2
plot!(
    pII;
    inset = (2, bbox(0.15, -0.18, 0.7, 0.15, :left, :top)),
    subplot = 6,
    bg_inside = :white,
    ticks = false,
    grid = false,
)

min_val = minimum(log10.(abs.(sigma_hm)))
max_val = maximum(log10.(abs.(sigma_hm)))

# Clear previous traces on subplot 6
plot!(subplot = 6, bg_inside = :white, legend = false)

x_pad = (max_val - min_val) * 0.1

# Horizontal colorbar
heatmap!(
    collect(min_val:0.01:max_val),
    1.2:0.1:1.7,
    [x for y in 1.2:0.1:1.7, x in min_val:0.01:max_val];
    clims = (min_val, max_val),
    subplot = 6,
    cb = false,
    color = :inferno,
    ylims = (0.3, 2.5),
    xlims = (min_val - x_pad, max_val + x_pad),
    xticks = false,
    yticks = false,
    framestyle = :none,
)

# Border around the colored region
plot!(
    [min_val, max_val, max_val, min_val, min_val],
    [1.2, 1.2, 1.7, 1.7, 1.2];
    subplot = 6,
    linecolor = :black,
    linewidth = 1.0,
    label = "",
)

# Colorbar ticks and labels
ticks_x = [-3, -2, -1, 0, 1]

for tx in ticks_x
    if min_val <= tx <= max_val
        # Tick mark
        plot!(
            [tx, tx], [1.2, 1.05];
            subplot = 6,
            linecolor = :black,
            linewidth = 1.0,
            label = "",
        )

        # Tick label
        annotate!(
            [tx], [0.6],
            [text(string(tx), 8, :center, "Computer Modern")];
            subplot = 6,
        )
    end
end

# Final adjustment to subplot 2
plot!(pII, top_margin = 6mm, subplot = 2)


# ==================================================
# SAVE FIGURE
# ==================================================

savefig(pII, joinpath(results_path, "Fig2.pdf"))

println("Figure 2 saved.")