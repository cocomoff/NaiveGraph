# 無向グラフのテスト

N = 5
g = Graph(N)
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

ng = [
    Set{Int}([2, 3]),       # in 1
    Set{Int}([1, 3]),    # in 2
    Set{Int}([1, 2, 4]), # in 3
    Set{Int}([3, 5]),    # in 4
    Set{Int}([4])     # in 5
]

dg = [2, 2, 3, 2, 1]

@test g.nodes == Set{Int}([1, 2, 3, 4, 5])
for i in 1:N
    @test g.adj[i] == ng[i]
    @test neighbors(g, i) == ng[i]
    @test degree(g, i) == dg[i]
end