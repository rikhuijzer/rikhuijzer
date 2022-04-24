Base.@kwdef struct Info
    # For example, "Foo.jl"
    name::String
    language::String = "Julia"
    color::String = "blueviolet"
    # For example, "example/Foo.jl".
    repo::String
end

function Info(repo::String)
    name = last(split(repo, '/'))
    return Info(; name, repo)
end

_url(info::Info) = "https://github.com/$(info.repo)"

@assert _url(Info("example/Foo.jl")) == "https://github.com/example/Foo.jl"

test_info = Info("rikhuijzer/PlutoStaticHTML.jl")

function line(info::Info)
    # Using a badge because text with not align nicely with the stars badge.
    badge_name = info.name == "cache-install" ? "cache install" : info.name
    name_badge = "https://img.shields.io/badge/$(badge_name)-$(info.language)-$(info.color).svg"
    stars_badge = "https://shields.io/github/stars/$(info.repo)"
    url = _url(info)
    return """
        [![$(info.name)]($name_badge)]($url)
            ![$(info.name) stars]($stars_badge)
        """
end

@assert line(test_info) == """
    [![PlutoStaticHTML.jl](https://img.shields.io/badge/PlutoStaticHTML.jl-Julia-blueviolet.svg)](https://github.com/rikhuijzer/PlutoStaticHTML.jl)
        ![PlutoStaticHTML.jl stars](https://shields.io/github/stars/rikhuijzer/PlutoStaticHTML.jl)
    """

main_contributor = [
    Info("rikhuijzer/PlutoStaticHTML.jl"),
    Info("rikhuijzer/JuliaTutorialsTemplate"),
    Info("rikhuijzer/PrecompileSignatures.jl"),
    Info("JuliaBooks/Books.jl"),
    Info("JuliaDataScience/JuliaDataScience"),
    Info(; name="cache-install", repo="rikhuijzer/cache-install", language="Nix", color="blue"),
    Info("rikhuijzer/PowerAnalyses.jl"),
    Info("rikhuijzer/Resample.jl"),
    Info("julia-actions/cache"),
    Info("rikhuijzer/Skans.jl"),
]

contributor = [
    Info("fonsp/Pluto.jl"),
    Info("TuringLang/Turing.jl"),
    Info("JuliaAI/MLJBase.jl"),
    Info("JuliaAI/MLJGLMInterface.jl")
]

sep = "\n  "

text = """
    ### Main contributor

      $(join(line.(main_contributor), sep))

    ### Regular contributor

      $(join(line.(contributor), sep))
    """
print(text)

println("Overwriting README.md with the printed text. Are you sure (y/N)?")
response = readline()
if response == "y"
    write("README.md", text)
end
