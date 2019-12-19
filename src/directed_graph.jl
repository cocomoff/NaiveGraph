export DiGraph, copy
mutable struct DiGraph <: AbstractGraph
    nV::Int
    nE::Int
    nodes::Set{Int}
    adj::Dict{Int, Set{Int}}

    # constructor
    function DiGraph(n::Int)
        nodes = Set{Int}()
        adj = Dict{Int, Set{Int}}()
        for i in 1:n
            push!(nodes, i)
            adj[i] = Set{Int}()
        end
        new(n, 0, nodes, adj)
    end

    function DiGraph(es::Array{Tuple{Int, Int}, 1})
        n = 1
        for edge in es
            n = max(n, edge[1], edge[2])
        end
        g = DiGraph(n)
        for edge in es
            add_edge!(g, edge)
        end
        g
    end
end

function copy(g::DiGraph)
    DiGraph(g.nV, g.nE, deepcopy(g.nodes), deepcopy(g.adj))
end

export add_node!, add_edge!, remove_node!, remove_edge!,
out_neighbors, in_neighbors, out_degree, in_degree
function add_node!(g::DiGraph, v::Int)
    flag = v ∈ g.nodes
    if !flag
        push!(g.nodes, v)
        g.adj[v] = Set{Int}()
        g.nV += 1
    end
    return !flag
end

function add_node!(g::DiGraph)
    max_v = g.nV + 1
    while max_v ∈ g.nodes
        max_v += 1
    end
    push!(g.nodes, max_v)
    g.adj[max_v] = Set{Int}()
    g.nV += 1
end

function remove_node!(g::DiGraph, v::Int)
    flag = v ∈ g.nodes
    if flag
        delete!(g.nodes, v)
        delete!(g.adj, v)
        g.nV -= 1
        for u in g.nodes
            if v in g.adj[u]
                delete!(g.adj[u], v)
                g.nE -= 1
            end
        end
    end
    return flag
end

function remove_edge!(g::DiGraph, e::Tuple{Int, Int})
    flag = e[1] in g.nodes && e[2] in g.nodes
    if flag
        delete!(g.adj[e[1]], e[2])
        g.nE -= 1
    end
    return flag
end
remove_edge!(g::DiGraph, u::Int, v::Int) = remove_edge!(g, (u, v))
out_neighbors(g::DiGraph, u::Int) = g.adj[u]
function in_neighbors(g::DiGraph, u::Int)
    ans = Set{Int}()
    for v in g.nodes
        if v != u && u in g.adj[v]
            push!(ans, v)
        end
    end
    return ans
end

function add_edge!(g::DiGraph, e::Tuple{Int, Int})
    flag = e[1] in g.nodes && e[2] in g.nodes
    if flag
        if e[2] ∉ g.adj[e[1]]
            push!(g.adj[e[1]], e[2])
            g.nE += 1
        end
    end
    return flag
end
add_edge!(g::DiGraph, u::Int, v::Int) = add_edge!(g, (u, v))

function out_degree(g::DiGraph, v::Int)
    if v in g.nodes
        return length(g.adj[v])
    else
        return -1
    end
end

function in_degree(g::DiGraph, v::Int)
    if v in g.nodes
        return length(in_neighbors(g, v))
    else
        return -1
    end
end
