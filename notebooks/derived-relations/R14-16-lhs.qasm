OPENQASM 2.0;
include "qelib1.inc";
quditdim 37
qreg q[2];
cx q[1], q[0];
h^-1 q[0];
s^binv q[0];
h^-1 q[0];
s^b q[0];
h q[0];
