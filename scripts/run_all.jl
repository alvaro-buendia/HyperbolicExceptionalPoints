# scripts/run_all.jl

println("========================================")
println(" Reproducing all figures for the paper ")
println("========================================\n")

# ----------------------
# Environment setup
# ----------------------
using Pkg

# Activate project (root folder)
project_path = joinpath(@__DIR__, "..")
Pkg.activate(project_path)

# Install exact dependencies
Pkg.instantiate()

# ----------------------
# Load packages
# ----------------------
using LaTeXStrings
using Plots
using Measures

# ----------------------
# Ensure results folder exists
# ----------------------
results_dir = joinpath(project_path, "results")
mkpath(results_dir)

# ----------------------
# List of figure scripts
# ----------------------
figures = [
    "Fig1c.jl",
    "Fig2.jl",
]

# ----------------------
# Run all figures
# ----------------------
for fig in figures
    path = joinpath(@__DIR__, fig)
    println("Running $fig ...")

    try
        @time include(path)
        println("Finished $fig\n")
    catch e
        println("Error while running $fig:")
        println(e)
        println()
    end
end

println("========================================")
println(" All figures processed ")
println("========================================")
