# SimpleQuantum

This is a demonstration project for quantum computation. 

## Qubits

The basic unit of quantum computation is a *qubit* which is a unit
vector in $C^2$. The function `Qubit()` returns a new qubit corresponding
to a zero. 

We provide the constants `Q0` and `Q1` representing zero and one, 
respectively.

More generally, `Qubit(w,z)` where `w` and `z` are numbers (not both zero)
creates a new qubit whose unit vector representation is `[w;z]` normalized.

The `measure!` function is used to value of the qubit. If `q` is the qubit
specified by `[w;z]` with `abs(w)^2 + abs(z)^2 == 1`, then `measure!(q)` 
returns `0` with probability `abs(w)^2` and `1` with probability `abs(z)^2`, 
and overwrites the value of `q` with `Q0` or `Q1`, respectively.

```julia
julia> q = Qubit(3,4im)
Qubit(0.6 + 0.0im,0.0 + 0.8im)

julia> measure!(q)
1

julia> q
Qubit(0.0 + 0.0im,1.0 + 0.0im)

julia> q==Q1
true
```

The function `normalize!` is used internally to rescale a qubit so its
vector is unit length. Although this function is exposed to the user,
it is unlikely to ever be needed.

## Registers

A *register* is a list of qubits. The function `Register(n::Int)` creates
a new register all of whose qubits are `Q0`. 

A register can also be created by specifying the qubits as arguments to 
the register.
```julia

julia> R = Register(3)
Register(Qubit(1.0 + 0.0im,0.0 + 0.0im),Qubit(1.0 + 0.0im,0.0 + 0.0im),Qubit(1.0 + 0.0im,0.0 + 0.0im))

julia> R = Register(Q0,Q1,Q1)
Register(Qubit(1.0 + 0.0im,0.0 + 0.0im),Qubit(0.0 + 0.0im,1.0 + 0.0im),Qubit(0.0 + 0.0im,1.0 + 0.0im))
```

Use `length(R)` to determine the number of qubits in the register, `R`.

To measure a particular qubit in a register, use `measure!(R,k)`.

Individual qubits can be inspected and set using `[]` notation, although this
is not permitted in a quantum computation.
```julia
julia> R = Register(3);

julia> R[1] = Qubit(3,4)
Qubit(0.6 + 0.0im,0.8 + 0.0im)

julia> measure!(R,1)
0

julia> R[1]
Qubit(1.0 + 0.0im,0.0 + 0.0im)
```

## Gates

Not available yet!
