OPENQASM 2.0;
include "qelib1.inc";
quditdim 37
qreg q[3];
cx^-1 q[0], q[2];
cx^-a q[2], q[1];
cx q[0], q[2];
cx^a q[2], q[1];
