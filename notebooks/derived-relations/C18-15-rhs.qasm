OPENQASM 2.0;
include "qelib1.inc";
quditdim 37
qreg q[3];
cx q[2], q[1];
cz^a q[0], q[1];
cz^-a q[0], q[2];
