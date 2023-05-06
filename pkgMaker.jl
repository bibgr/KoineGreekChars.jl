using PkgTemplates

templ = Template(;
    user = "cnaak",
    authors = [
        "C. Naaktgeboren <NaaktgeborenC.PhD@gmail.com>",
    ],
    host = "github.com",
    julia = v"^1.8",
    interactive = false,
    plugins = Plugin[
        # Elementary Plugins
        # ------------------
        ProjectFile(; version=v"0.1.0"),    # Creates a 'Project.toml'.
        SrcDir(),                           # Creates a module entrypoint.
        Tests(;                             # Sets up testing for packages.
            project=true                    # Creates 'test/Project.toml'. Req. julia v"^1.2"
        ),
        Readme(;                            # Creates a 'README.md'.
            file = "./README.md",           # Don't loose local edits.
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

        # 1. Test Code Coverage
        # "Codecov is the all-in-one code coverage reporting solution for any test suite"
        Codecov(;                           # Sets up code coverage submission CI -> Codecov.
            file=nothing,                   # Template file for .codecov.yml, or nothing to
        ),                                  #   [...] create no file.

        # 2. Documentation
        #
    ],
);

