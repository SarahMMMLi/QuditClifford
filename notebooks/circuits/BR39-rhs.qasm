OPENQASM 2.0;
include "qelib1.inc";
quditdim 23
qreg q[2];
h^-1 q[1];
s^-a q[1];
h^-1 q[1];
s^-ainv q[1];
h^-1 q[1];
s^{-a*(bminus1 + 1)} q[1];
h q[1];
swap q[0], q[1];
cz^-1 q[0], q[1];
h^3 q[0];
s^-a q[0];
h q[0];
s^a q[1];
