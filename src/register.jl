export Register
import Base: length

"""
`Register(n::Int=1)` creates a new quantum register holding `n`
qubits, all set to `Q0`.

`Register(q1,q2,...)` or `Register([q1,q2,...])` creates a new quantum
register holding the qubits `q1`, `q2`, etc.

`Register(b1,b2,...)` where `b1,b2,...` are 0s and 1s creates a new register
holding qubits `Qubit(b1)`, `Qubit(b2)`, etc. 
"""
mutable struct Register <: QuantumState
    vec::Vector{CC}
    function Register(nbits::Integer = 1)
        if nbits < 0
            throw(DomainError(nbits, "Number of bits must be positive."))
        end
        if nbits == 0
            nbits = 1
        end 
        v = zeros(CC, 1 << nbits)
        v[1] = one(CC)
        new(v)
    end

    # This constructor generally should not be used the user.
    function Register(v::Vector{T}) where {T<:Number}
        new(v)
    end
end


function Register(bits::Integer...)
    qlist = Qubit.(bits)
    return Register(qlist...)
end



function Register(Qlist::Qubit...)
    nbits = length(Qlist)
    v = Qlist[1].vec
    for j = 2:nbits
        v = kron(v, Qlist[j].vec)
    end
    return Register(v)
end

function Register(QQ::Vector{Qubit})
    Qtuple = Tuple(q for q in QQ)
    return Register(Qtuple...)
end

"""
`length(R::Register)` is the number of qubits in `R`.
(The number of complex numbers in its vector is `2^n` where `n`
is the number of qubits.)
"""
length(R::Register)::Int = lg(length(R.vec))
