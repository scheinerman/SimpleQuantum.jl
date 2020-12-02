export Qubit, Q0, Q1, RandomQubit

"""
A `Qubit` represents a single qubit. 

* `Qubit()` creates the `|0>` value; equivalent to `Qubit(1,0)`. 
* `Qubit(0)` and `Qubit(1)` create the `|0>` and `|1>` values, respecively. They are also
available as `Q0` and `Q1`.
* `Qubit(w::Complex,z::Complex)` creates a qubit whose state is `[w;z]` (normalized)
"""
mutable struct Qubit <: QuantumState
    vec::Vector{CC}
    function Qubit(w, z)
        v = [w; z]
        v /= _norm(v)
        new(v)
    end
end

Qubit(b::Integer=0) = b==0 ? Qubit(1,0) : Qubit(0,1)


"""
`Q0` is the value `Qubit(1,0)` which is a quantum zero.
"""
const Q0 = Qubit(0)

"""
`Q1` is the value `Qubit(0,1)` which is a quantum one.
"""
const Q1 = Qubit(1)




function show(io::IO, q::Qubit)
    x = q.vec[1]
    y = q.vec[2]
    print(io, "Qubit($x,$y)")
end




"""
`measure!(q::Qubit)` performs a quantum measurement on the qubit `q`
returning `0` or `1` and overwriting `q` to be either `Q0` or `Q1`
respectively.
"""
function measure!(q::Qubit)::Int
    p = abs(q.vec[2])^2
    val::Int = 0
    if rand() < p
        val = 1
        q.vec = Q1.vec
    else
        q.vec = Q0.vec
    end
    return val
end

"""
`RandomQubit()` returns a random qubit. 
"""
function RandomQubit()
    a = randn() + randn() * im
    b = randn() + randn() * im
    return Qubit(a, b)
end
