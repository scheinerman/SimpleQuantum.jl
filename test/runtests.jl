using Test
using SimpleQuantum

q = Q0
@test measure!(q) == 0
q = Q1
@test measure!(q) == 1

R = Register(3)
@test measure!(R,1) == 0

q = Qubit(3,4im)
w = q.vec[1]
z = q.vec[2]
@test w==0.6
@test z==0.8im
R[2] = q 
v = measure!(R,2)
@test v==0 || v==1
@test R[2]==Q0 || R[2]==Q1