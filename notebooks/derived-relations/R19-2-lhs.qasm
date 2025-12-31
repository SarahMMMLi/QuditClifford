OPENQASM 2.0;
include "qelib1.inc";
quditdim 37
qreg q[2];
s^a q[1];
h q[1];
cx q[1], q[0];
