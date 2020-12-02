module SimpleQuantum
using LinearAlgebra, SparseArrays, SimpleRandom

import Base: show, ==, length, kron


export measure!, (⊗), lg


RR = Float64            # shortcut for real
CC = Complex{RR}        # shortcut for complex

 
"""
`A⊗B` is the Kronecker (tensor) product of `A` and `B`.
"""
⊗(A) = A
⊗(A, B) = kron(A, B)
⊗(A, B, C...) = ⊗(A, ⊗(B, C...))

"""
`lg(n)` is a fast, base-2 log of `n` assuming `n` is a power of 2.
"""
function lg(n::Int)::Int
    count = 0
    while n>1
        n = n>>1
        count += 1
    end
    return count 
end


include("quantum_state.jl")
include("qubit.jl")
include("register.jl")



end  # end of module
