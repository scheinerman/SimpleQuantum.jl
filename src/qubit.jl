export Qubit, Q0, Q1

"""
A `Qubit` represents a single qubit. 

* `Qubit()` creates the `|0>` value; equivalent to `Qubit(1,0)`. See also `Q0` and `Q1`.
* `Qubit(w::Complex,z::Complex)` creates a qubit whose state is `[w;z]` (normalized)
"""
mutable struct Qubit
    vec::Vector{CC}
    function Qubit(w, z)
        v = [w; z]
        v /= _norm(v)
        new(v)
    end
end

(==)(q1::Qubit, q2::Qubit) = q1.vec == q2.vec

_norm(q::Qubit)::RR = _norm(q.vec)

Qubit() = Qubit(1, 0)

"""
`Q0` is the value `Qubit(1,0)` which is a quantum zero.
"""
const Q0 = Qubit(1, 0)

"""
`Q1` is the value `Qubit(0,1)` which is a quantum one.
"""
const Q1 = Qubit(0, 1)


"""
The `normalize!` function is used to ensure that `Qubit`s 
are unit vectors. Not likely to be used by users.
"""
function normalize!(q::Qubit)::Nothing
    q.vec /= _norm(q)
    nothing
end


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
