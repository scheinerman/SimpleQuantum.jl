export Register

"""
`Register(n::Int=1)` creates a new quantum register holding `n`
qubits, all set to `Q0`.
"""
struct Register
    vec::Vector{CC}
    function Register(nbits::Int = 1)
        if nbits <= 0
            throw(DomainError(nbits, "Number of bits must be positive."))
        end
        v = zeros(CC, 1 << nbits)
        v[1] = one(CC)
        new(v)
    end
end



# All this is WRONG!!!  (Old code to be removed.)
# struct Register
#     qbits::Vector{Qubit}
#     function Register(nbits::Int = 1)
#         if nbits <= 0
#             throw(DomainError(nbits, "Number of bits must be positive."))
#         end
#         vec = Vector{Qubit}(undef, nbits)
#         for j = 1:nbits
#             vec[j] = Q0
#         end
#         new(vec)
#     end
# end

# """
# `Register(n::Int=1)` returns a new register with `n` qubits all set to `Q0`.

# `Register(qlist::Qubit...)` returns a new register with the qubits specified 
# by the arguments.
# """
# function Register(qbits::Qubit...)::Register
#     nbits = length(qbits)
#     R = Register(nbits)
#     for j = 1:nbits
#         R[j] = qbits[j]
#     end
#     return R
# end


# getindex(R::Register, k::Int) = R.qbits[k]
# setindex!(R::Register, q::Qubit, k::Int) = R.qbits[k] = q


# measure!(R::Register, k::Int)::Int = measure!(R[k])

# """
# `length(R::Register)` returns the number of qubits in 
# the register `R`.
# """
# length(R::Register) = length(R.qbits)

# function show(io::IO, R::Register)
#     print(io, "Register(")
#     nbits = length(R)
#     for j = 1:nbits-1
#         print(io, R[j], ",")
#     end
#     print(io, R[nbits], ")")
# end
