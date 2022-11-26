using Plots, Test

const plots_path = escape_string(pkgdir(Plots))

@testset "Default Backend" begin
    out = withenv("PLOTS_DEFAULT_BACKEND" => "Plotly") do
        run(```
           $(Base.julia_cmd()) -E """
               using Pkg
               Pkg.activate(; temp = true)
               Pkg.develop(path = \"$(plots_path)\")
               Pkg.status(\"Plots\")
               @show ENV[\"PLOTS_DEFAULT_BACKEND\"]
               using Test
               using Plots
               @test backend() == Plots.PlotlyBackend()
               """
           ```)
    end
    @test out.exitcode == 0
end
