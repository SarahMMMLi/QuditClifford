OPENQASM 2.0;
include "qelib1.inc";
quditdim 37
qreg q[2];
s^-1 q[0];
cx q[1], q[0];
cz^-1 q[0], q[1];
s^2 q[0];
s q[1];
