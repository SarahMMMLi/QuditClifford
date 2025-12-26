OPENQASM 2.0;
include "qelib1.inc";
quditdim 37
qreg q[3];
cz q[1], q[2];
cx q[0], q[1];
