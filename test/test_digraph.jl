# 有向グラフのテスト

g = DiGraph(5)
@test g.nodes == Set{Int}([1, 2, 3, 4, 5])
@test g.nV == 5
@test g.nE == 0

add_edge!(g, 1, 2)
add_edge!(g, 1, 3)
add_edge!(g, 2, 3)
add_edge!(g, 3, 4)
add_edge!(g, 4, 5)
add_edge!(g, 3, 4)  # duplicate

@test g.nodes == Set{Int}([1, 2, 3, 4, 5])
@test g.adj[1] == Set{Int}([2, 3])
@test g.adj[2] == Set{Int}([3])
@test g.adj[3] == Set{Int}([4])
@test g.adj[4] == Set{Int}([5])
@test g.adj[5] == Set{Int}()

@test g.nV == 5
@test g.nE == 5