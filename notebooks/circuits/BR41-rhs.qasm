OPENQASM 2.0;
include "qelib1.inc";
quditdim 23
qreg q[3];
swap q[1], q[2];
h^-1 q[0];
s^dinv q[0];
h^-1 q[0];
s^d q[0];
h q[0];
swap q[0], q[1];
cx q[1], q[0];
cz^dinv q[1], q[2];
