module SimpleQuantum
using LinearAlgebra, SparseArrays

import Base: show, ==, length, kron


export normalize!, measure!, (⊗)

export _norm # eventually, I won't export this

RR = Float64            # shortcut for real
CC = Complex{RR}        # shortcut for complex


function _norm(v::Vector)::RR
    real(sqrt(v' * v))
end


"""
`A⊗B` is the Kronecker (tensor) product of `A` and `B`.
"""
⊗(A) = A
⊗(A,B) = kron(A,B)
⊗(A,B,C...) = ⊗(A,⊗(B,C...))


include("qubit.jl")
include("register.jl")



end  # end of module
