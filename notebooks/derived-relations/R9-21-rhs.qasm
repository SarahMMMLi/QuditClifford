OPENQASM 2.0;
include "qelib1.inc";
quditdim 37
qreg q[2];
h q[1];
s^g q[1];
h q[1];
s^ginv q[1];
h q[1];
s^g q[1];
cx^g q[1], q[0];
