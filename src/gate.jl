export add_gate, gate, gate_help


# These are tables of the gates and their descriptions
gate_table = Dict{Symbol, Matrix{CC}}()
gate_descr = Dict{Symbol,String}()

"""
`add_gate(S::Symbol, M::Matrix, descr::String)` adds a new gate to the 
library of gates. 
* `S` is the symbol associated with this gate.
* `M` is the matrix for this gate.
* `descr` is a description of the action of the gate.
"""
function add_gate(S::Symbol, M::Matrix, descr::String="No description available")
    gate_table[S] = M
    gate_descr[S] = descr 
end

"""
`gate(S::Symbol)` returns the gate associated with the symbol `S`.
"""
function gate(S::Symbol)
    if haskey(gate_table,S)
        return gate_table[S]
    end 
    throw(error("No such gate, $S"))
end 

"""
`gate_help(S::Symbol)` prints a short help message describing gate `S`.
"""
function gate_help(S::Symbol)
    if haskey(gate_descr,S)
        println(":$S\t",gate_descr[S])
        return
    end
    println("Unknown gate, $S")
end

add_gate(:I, [1 0; 0 1], "Identity (nop) gate")
add_gate(:X, [0 1; 1 0], "Qubit swap (Pauli X)")
add_gate(:H, [1 1; 1 -1]/sqrt(2), "Hadammard gate")
