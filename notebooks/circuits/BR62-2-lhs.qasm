OPENQASM 2.0;
include "qelib1.inc";
quditdim 23
qreg q[3];
cz q[1], q[2];
swap q[0], q[1];
cx q[1], q[0];
