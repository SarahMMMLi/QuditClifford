OPENQASM 2.0;
include "qelib1.inc";
quditdim 37
qreg q[2];
cz q[0], q[1];
cx^a q[0], q[1];
s^2*a q[0];
