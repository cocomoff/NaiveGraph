module NaiveGraph

abstract type AbstractGraph end

export Graph, copy

include("directed_graph.jl")
include("generate_sample_graph.jl")

end # end of Naive Graph module