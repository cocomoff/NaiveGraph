# 有向グラフのテスト

N = 5
g = DiGraph(N)
@test g.nodes == Set{Int}([1, 2, 3, 4, 5])
@test g.nV == N
@test g.nE == 0

ES = Set{Int}()

add_edge!(g, 1, 2)
add_edge!(g, 1, 3)
add_edge!(g, 2, 3)
add_edge!(g, 3, 4)
add_edge!(g, 4, 5)
add_edge!(g, 3, 4)  # duplicate

ing = [
    Set{Int}(),       # in 1
    Set{Int}([1]),    # in 2
    Set{Int}([1, 2]), # in 3
    Set{Int}([3]),    # in 4
    Set{Int}([4])     # in 5
]

og = [2, 1, 1, 1, 0]
ig = [0, 1, 2, 1, 1]

@test g.nodes == Set{Int}([1, 2, 3, 4, 5])
@test g.adj[1] == Set{Int}([2, 3])
@test g.adj[2] == Set{Int}([3])
@test g.adj[3] == Set{Int}([4])
@test g.adj[4] == Set{Int}([5])
@test g.adj[5] == ES

for i in 1:N
    @test out_neighbors(g, i) == g.adj[i]
    @test out_degree(g, i) == og[i]
    @test in_neighbors(g, i) == ing[i]
    @test in_degree(g, i) == ig[i]
end

@test g.nV == 5
@test g.nE == 5