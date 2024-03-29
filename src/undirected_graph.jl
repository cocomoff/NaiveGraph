export Graph, copy
mutable struct Graph <: AbstractGraph
    nV::Int
    nE::Int
    nodes::Set{Int}
    adj::Dict{Int, Set{Int}}

    # constructor
    function Graph(n::Int)
        nodes = Set{Int}()
        adj = Dict{Int, Set{Int}}()
        for i in 1:n
            push!(nodes, i)
            adj[i] = Set{Int}()
        end
        new(n, 0, nodes, adj)
    end

    function Graph(es::Array{Tuple{Int, Int}, 1})
        n = 1
        for edge in es
            n = max(n, edge[1], edge[2])
        end
        g = Graph(n)
        for edge in es
            add_edge!(g, edge)
        end
        g
    end
end

function copy(g::Graph)
    Graph(g.nV, g.nE, deepcopy(g.nodes), deepcopy(g.adj))
end

export add_node!, add_edge!, remove_node!, remove_edge!,
neighbors, degree

function add_node!(g::Graph, v::Int)
    flag = v ∈ g.nodes
    if !flag
        push!(g.nodes, v)
        g.adj[v] = Set{Int}()
        g.nV += 1
    end
    return !flag
end

function add_node!(g::Graph)
    max_v = g.nV + 1
    while max_v ∈ g.nodes
        max_v += 1
    end
    push!(g.nodes, max_v)
    g.adj[max_v] = Set{Int}()
    g.nV += 1
end

function remove_node!(g::Graph, v::Int)
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

function remove_edge!(g::Graph, e::Tuple{Int, Int})
    flag = e[1] in g.nodes && e[2] in g.nodes
    flag2 = e[1] in g.adj[e[2]] && e[2] in g.adj[e[1]]
    if flag && flag2
        delete!(g.adj[e[1]], e[2])
        delete!(g.adj[e[2]], e[1])
        g.nE -= 1
    end
    return flag
end
remove_edge!(g::Graph, u::Int, v::Int) = remove_edge!(g, (u, v))
neighbors(g::Graph, u::Int) = g.adj[u]

function add_edge!(g::Graph, e::Tuple{Int, Int})
    flag = e[1] in g.nodes && e[2] in g.nodes
    if flag
        if e[2] ∉ g.adj[e[1]] && e[1] ∉ g.adj[e[2]]
            push!(g.adj[e[1]], e[2])
            push!(g.adj[e[2]], e[1])
            g.nE += 1
        end
    end
    return flag
end
add_edge!(g::Graph, u::Int, v::Int) = add_edge!(g, (u, v))

function degree(g::Graph, v::Int)
    if v in g.nodes
        return length(g.adj[v])
    else
        return -1
    end
end