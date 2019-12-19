module NaiveGraph

abstract type AbstractGraph end

include("directed_graph.jl")
include("undirected_graph.jl")
include("generate_sample_graph.jl")

end # end of Naive Graph module