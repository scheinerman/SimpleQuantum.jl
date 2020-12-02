
export _norm # eventually, I won't export this
export QuantumState, normalize!, apply! 

"""
`QuantumState` is an abstract supertype of `Qubit`
and `Register`.
"""
abstract type QuantumState end



function _norm(v::Vector)::RR
    real(sqrt(v' * v))
end

_norm(q::QuantumState)::RR = _norm(q.vec)


"""
The `normalize!` function is used to ensure that `Qubit`s and `Register`s
are unit vectors. Not likely to be used by users.
"""
function normalize!(q::QuantumState)::Nothing
    q.vec /= _norm(q)
    nothing
end


(==)(q1::QuantumState, q2::QuantumState) = q1.vec == q2.vec


"""
`apply!(A,q::QuantumState)` overwrites the state vector in `q`
by multiplying it by `A`. We assume (but do not check) that `A`
is a unitary matrix of the appropriate size.
"""
function apply!(A::AbstractArray{T,2}, q::QuantumState) where T 
    q.vec = A*q.vec
    normalize!(q)
    nothing
end