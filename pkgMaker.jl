using PkgTemplates

# Show command line arguments
# ---------------------------

@show ARGS

# Prepare template
# ----------------

templ = Template(;
    user = "cnaak",
    authors = [
        "C. Naaktgeboren <NaaktgeborenC.PhD@gmail.com>",
    ],
    host = "github.com",
    julia = v"1.8",
    interactive = false,
    plugins = PkgTemplates.Plugin[
        # Elementary Plugins
        # ------------------
        ProjectFile(; version=v"0.1.0"),    # Creates a 'Project.toml'.
        SrcDir(),                           # Creates a module entrypoint.
        Tests(;                             # Sets up testing for packages.
            project=true                    # Creates 'test/Project.toml'. Req. julia v"^1.2"
        ),
        Readme(;                            # Creates a 'README.md'.
            destination="README.md",
            inline_badges=false,            # Badges on the same line as package name?
        ),
        License(;                           # Creates a license file.
            name="MIT",
            path=nothing,
            destination="LICENSE",
        ),
        # Continuous Integration (CI) Plugins
        # -----------------------------------

        # 1. Travis CI
        # Thanks 2 https://discourse.julialang.org/t/built-julia-by-platform-arch/29144/2
        # Travis CI is "Build Faster / Test your code in minutes / Deploy with confidence."
        TravisCI(;
            linux = true,
            osx = false,
            windows = false,
            x64 = true,
            x86 = false,
            arm64 = false,
            coverage = true,
            extra_versions = ["1.4", "1.8"],
		),

        # 2. Test Code Coverage
        # "Codecov is the all-in-one code coverage reporting solution for any test suite"
        Codecov(;                           # Sets up code coverage submission CI -> Codecov.
            file=nothing,                   # Template file for .codecov.yml, or nothing to
        ),                                  #   [...] create no file.

        # 3. Documentation
        # Documenter.jl — "A documentation generator for Julia"
        Documenter{NoDeploy}(;
            make_jl = "template-docs-make.jl",
            index_md = "template-docs-index.md",
            assets = String[],
            logo = Logo(;
                light = "KGC-logo.png",
                dark  = "KGC-logo.png",
            ),
            devbranch = nothing,
            edit_link = :devbranch,
            makedocs_kwargs = Dict{Symbol,Any}(),
        ),
    ],
);

# Apply template
# --------------

for a in ARGS
    println("Applying template into '$(a)':")
    templ(a)
    println("Done.\n")
end

