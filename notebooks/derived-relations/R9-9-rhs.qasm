OPENQASM 2.0;
include "qelib1.inc";
quditdim 37
qreg q[2];
h q[0];
s^g q[0];
h q[0];
s^ginv q[0];
h q[0];
s^g q[0];
cx^g q[0], q[1];
