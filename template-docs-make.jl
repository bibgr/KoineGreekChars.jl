# Replace all __PRJ__ with Project name
# Replace all __LOG__ with prjLogo name
# Delete this comments

# Thanks to DrWatson's Documenter setup!
cd(@__DIR__)
using Pkg
CI = get(ENV, "CI", nothing) == "true" || get(ENV, "GITHUB_TOKEN", nothing) !== nothing
CI && Pkg.activate(@__DIR__)
CI && Pkg.instantiate()

using Documenter
using DocumenterTools: Themes

using __PRJ__

# %%
# download the themes
for file in (
        "juliadynamics-lightdefs.scss",
        "juliadynamics-darkdefs.scss",
        "juliadynamics-style.scss"
    )
    download(
        "https://raw.githubusercontent.com/JuliaDynamics/doctheme/master/$file",
        joinpath(@__DIR__, file)
    )
end

# create the themes
for w in ("light", "dark")
    header = read(joinpath(@__DIR__, "juliadynamics-style.scss"), String)
    theme = read(joinpath(@__DIR__, "juliadynamics-$(w)defs.scss"), String)
    write(joinpath(@__DIR__, "juliadynamics-$(w).scss"), header*"\n"*theme)
end

# compile the themes
Themes.compile(
    joinpath(@__DIR__, "juliadynamics-light.scss"),
    joinpath(@__DIR__, "src/assets/themes/documenter-light.css"))
Themes.compile(
    joinpath(@__DIR__, "juliadynamics-dark.scss"),
    joinpath(@__DIR__, "src/assets/themes/documenter-dark.css"))

# Translate .jl sources into .md ones
using Literate

## for each FILE docs/src/*jl, convert to docs/src/*md with command
## Literate.markdown("src/tagging.jl", "src"; credit = false)

DocMeta.setdocmeta!(__PRJ__, :DocTestSetup, :(using __PRJ__); recursive=true)

# __PRJ__ docs:
makedocs(
    sitename = "__PRJ__",
    format = Documenter.HTML(
        prettyurls = get(ENV, "CI", nothing) == true
    ),
#    logo = "assets/__LOG__.svg",
#    modules = [__PRJ__, ],
#    pages = Any[
#        "Introduction" => "index.md",
#        "Examples" => Any[
#            "Tagging" => "tagging.md",
#        ],
#        "TutoriTests" => Any[
#            "Amounts" => "tt-amounts.md",
#        ],
#        "Reference" => "reference.md",
#    ],
)

# Documenter can also automatically deploy documentation to gh-pages.
# See "Hosting Documentation" and deploydocs() in the Documenter manual
# for more information.
#=deploydocs(
    repo = "<repository url>"
)=#
