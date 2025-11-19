OPENQASM 2.0;
include "qelib1.inc";
quditdim 23
qreg q[2];
h^-1 q[0];
s^-ainv q[0];
h^-1 q[0];
s^-a q[0];
h q[0];
swap q[0], q[1];
cx q[1], q[0];
s^-ainv q[1];
