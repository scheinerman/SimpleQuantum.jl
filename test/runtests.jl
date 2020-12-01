using Test
using SimpleQuantum

q = Q0
@test measure!(q) == 0
q = Q1
@test measure!(q) == 1


total = 0
for k = 1:1000
    local q = Qubit(3, 4im)
    local v = measure!(q)
    global total += v
    if v == 0
        @test q == Q0
    else
        @test q == Q1
    end
end
println("total = $total which should be around 640")


q = Qubit(3, 4im)
w = q.vec[1]
z = q.vec[2]
@test w == 0.6
@test z == 0.8im
