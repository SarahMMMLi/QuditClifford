OPENQASM 2.0;
include "qelib1.inc";
quditdim 23
qreg q[3];
cz q[0], q[1];
swap q[1], q[2];
cx q[2], q[1];
h^-1 q[0];
s^-1 q[0];
h^-1 q[0];
s^-1 q[0];
h^-1 q[0];
s^-d - 1 q[0];
h q[0];
swap q[0], q[1];
cx q[1], q[0];
