module SimpleQuantum
using LinearAlgebra

import Base: show, ==, length, kron


export normalize!, measure!

export _norm # eventually, I won't export this

RR = Float64            # shortcut for real
CC = Complex{RR}        # shortcut for complex


function _norm(v::Vector)::RR
    real(sqrt(v' * v))
end


include("qubit.jl")
include("register.jl")



end  # end of module
