OPENQASM 2.0;
include "qelib1.inc";
quditdim 37
qreg q[2];
cx q[0], q[1];
cz^-1 q[0], q[1];
s q[0];
s q[1];
