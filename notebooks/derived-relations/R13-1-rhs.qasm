OPENQASM 2.0;
include "qelib1.inc";
quditdim 37
qreg q[2];
cx^a q[1], q[0];
cz^b q[0], q[1];
h^-1 q[0];
s^-a q[0];
h^-1 q[0];
s^-ainv q[0];
h^-1 q[0];
s^{-a*(b + 1)} q[0];
h q[0];
s^-a*b q[1];
