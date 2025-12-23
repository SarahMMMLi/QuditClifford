OPENQASM 2.0;
include "qelib1.inc";
quditdim 37
qreg q[2];
cx^a q[0], q[1];
cz^-a q[0], q[1];
s^a**2 q[0];
s q[1];
