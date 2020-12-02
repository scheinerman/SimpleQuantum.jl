# SimpleQuantum

[![Build Status](https://travis-ci.com/scheinerman/SimpleQuantum.jl.svg?branch=master)](https://travis-ci.com/scheinerman/SimpleQuantum.jl)


This is a demonstration project for quantum computation using the quantum circuit model.



## Qubits

The basic unit of quantum computation is a *qubit* which is a unit
vector in $C^2$. The function `Qubit()` returns a new qubit corresponding
to a zero represented by the complex vector `[1+0im; 0+0im]`. 

We provide the constants `Q0` and `Q1` representing zero and one, 
respectively. The vector representation of `Q1` is `[0+0im;1+0im]`.

More generally, `Qubit(w,z)` where `w` and `z` are numbers (not both zero)
creates a new qubit whose unit vector representation is `[w;z]` normalized.
```julia
julia> using SimpleQuantum

julia> Q0 == Qubit(1,0)
true

julia> Q1 == Qubit(0,1)
true
```


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

A new register may be created by giving a list of qubits as arguments, or a vector of qubits, or a list of 0s and 1s.
```julia
julia> R = Register(Q1,Q1,Q0);

julia> Qvec = [Q1,Q1,Q0];

julia> S = Register(Qvec);  # holds same data as R

julia> T = Register(1,1,0); # holds same data as R
```

Use `length(R)` to determine the number of qubits in the register. Note that the number of 
complex values in `R`'s vector is `2^n` where `n` is the number of qubits.

The `measure!` function performs a quantum measurement on all the qubits in a register, 
returning their values as a vector of zeros and ones. After measurement, the qubits
in the register are reduced to `Q0`s and `Q1`s respectively.
```julia
julia> Q = Qubit(3,4im)
Qubit(0.6 + 0.0im,0.0 + 0.8im)

julia> R = Register(Q,Q,Q);

julia> R == Register(1,1,0)
false

julia> measure!(R)
3-element Array{Int64,1}:
 1
 1
 0

julia> R == Register(1,1,0)
true
```

**Need to do**: Apply `measure!` to individual qubits. Not sure how.


## Gates

Nothing yet.

## Quantum State

The `QuantumState` type is the common supertype of `Qubit` and `Register`. Both of these
types have a `vec` field that is a complex vector. Methods, such as `normalize!` act on 
that vector. 

The function `apply!(A,q)` applies the (presumably unitary) matrix `A` 
to the state vector in `q`, overwriting that vector.


## Miscellaneous

### Kronecker product
We define the operator `⊗` for Kronecker (tensor) product.
```julia
julia> [1;2] ⊗ [3;4]
4-element Array{Int64,1}:
 3
 4
 6
 8
```

### Base-2 logarithm for powers of two
We define `lg` as the base-2 logarithm for powers of two. 
It is faster than `Int(round(log(2,n)))`.
This gives incorrect results if `n` is not a power of two.
```julia
julia> lg(1024)
10
```

## Reference


Giacomo Nannicini, An Introduction to Quantum Computing, without the Physics, *SIAM Review*, vol. 62, no. 4, pp. 936–981.
