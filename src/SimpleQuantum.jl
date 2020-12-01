module SimpleQuantum
using LinearAlgebra

import Base: show, ==, length, getindex, setindex!


export Qubit, Q0, Q1, normalize!, measure!, Register

export _norm # eventually, I won't export this

RR = Float64            # shortcut for real
CC = Complex{RR}        # shortcut for complex


function _norm(v::Vector)::RR
    real(sqrt(v' * v))
end


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

`measure(R::Register,k::Int)` measures the `k`-th qubit in `R`.
"""
function measure!(q::Qubit)::Int
    p = abs(q.vec[2])
    val::Int = 0
    if rand() < p
        val = 1
        q.vec = Q1.vec
    else
        q.vec = Q0.vec
    end
    return val
end

struct Register
    qbits::Vector{Qubit}
    function Register(nbits::Int = 1)
        if nbits <= 0
            throw(DomainError(nbits, "Number of bits must be positive."))
        end
        vec = Vector{Qubit}(undef, nbits)
        for j = 1:nbits
            vec[j] = Q0
        end
        new(vec)
    end
end

"""
`Register(n::Int=1)` returns a new register with `n` qubits all set to `Q0`.

`Register(qlist::Qubit...)` returns a new register with the qubits specified 
by the arguments.
"""
function Register(qbits::Qubit...)::Register
    nbits = length(qbits)
    R = Register(nbits)
    for j = 1:nbits
        R[j] = qbits[j]
    end
    return R
end


getindex(R::Register, k::Int) = R.qbits[k]
setindex!(R::Register, q::Qubit, k::Int) = R.qbits[k] = q


measure!(R::Register, k::Int)::Int = measure!(R[k])

"""
`length(R::Register)` returns the number of qubits in 
the register `R`.
"""
length(R::Register) = length(R.qbits)

function show(io::IO, R::Register)
    print(io, "Register(")
    nbits = length(R)
    for j = 1:nbits-1
        print(io, R[j], ",")
    end
    print(io, R[nbits], ")")
end

end  # end of module
