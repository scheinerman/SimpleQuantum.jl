module SimpleQuantum
using LinearAlgebra, SparseArrays

import Base: show, ==, length, kron


export measure!, (⊗)


RR = Float64            # shortcut for real
CC = Complex{RR}        # shortcut for complex




# """
# `A⊗B` is the Kronecker (tensor) product of `A` and `B`.
# """
# ⊗(A) = A
# ⊗(A, B) = kron(A, B)
# ⊗(A, B, C...) = ⊗(A, ⊗(B, C...))

include("quantum_state.jl")
include("qubit.jl")
include("register.jl")



end  # end of module
