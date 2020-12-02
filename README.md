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

The `measure!` function is used to get the collapsed value of the qubit. If `q` is the qubit
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

The function `RandomQubit()` creates a random qubit.

The function `normalize!` is used internally to rescale a qubit so its
vector is unit length. Although this function is exposed to the user,
it is unlikely to ever be needed.

## Registers

A *register* is the state of a collection of qubits. The function `Register(n::Int)` creates
a new register to hold `n` qubits. It is a wrapper around a complex vector of length `2^n`. 
The initial state is that all the qubits are equal to `Q0`.

A new register may be created by giving a list of qubits as arguments, or a vector of qubits.
```julia
julia> R = Register(Q1,Q1,Q0);

julia> Qvec = [Q1,Q1,Q0];

julia> S = Register(Qvec);  # holds same data as R
```

Use `length(R)` to determine the number of qubits in the register. Note that the number of 
complex values in `R`'s vector is `2^n` where `n` is the number of qubits.

More to come (e.g., implement `measure!`).


## Quantum State

The `QuantumState` type is the common supertype of `Qubit` and `Register`. Both of these
types have a `vec` field that is a complex vector. Methods, such as `normalize!` act on 
that vector. 

The function `apply!(A,q)` applies the (presumably unitary) matrix `A` 
to the state vector in `q`, overwriting that vector.


## Gates

Nothing yet.




## Reference


Giacomo Nannicini, An Introduction to Quantum Computing, without the Physics, *SIAM Review*, vol. 62, no. 4, pp. 936–981.
