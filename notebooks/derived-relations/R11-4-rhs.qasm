OPENQASM 2.0;
include "qelib1.inc";
quditdim 37
qreg q[2];
cx^a q[1], q[0];
cz q[0], q[1];
s^-2*a q[1];
