OPENQASM 2.0;
include "qelib1.inc";
quditdim 37
qreg q[3];
cx q[0], q[2];
cz q[1], q[2];
cz^-1 q[0], q[1];
