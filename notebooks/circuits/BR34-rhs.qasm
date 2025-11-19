OPENQASM 2.0;
include "qelib1.inc";
quditdim 23
qreg q[2];
swap q[0], q[1];
cz^a q[0], q[1];
h^-1 q[0];
s^-ainv q[0];
h q[0];
s^-a q[0];
h q[0];
s^-ainv q[0];
h^2 q[0];
