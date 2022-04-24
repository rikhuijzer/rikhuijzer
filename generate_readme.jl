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
    name_badge = "https://img.shields.io/badge/$(info.name)-$(info.language)-$(info.color).svg"
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
