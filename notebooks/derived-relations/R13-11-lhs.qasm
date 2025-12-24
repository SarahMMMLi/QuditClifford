OPENQASM 2.0;
include "qelib1.inc";
quditdim 37
qreg q[2];
h^-1 q[1];
s^-a q[1];
h^-1 q[1];
s^-ainv q[1];
h^-1 q[1];
s^{-a*(b + 1)} q[1];
h q[1];
cx^t q[1], q[0];
