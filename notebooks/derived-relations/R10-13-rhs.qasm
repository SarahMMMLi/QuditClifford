OPENQASM 2.0;
include "qelib1.inc";
quditdim 37
qreg q[2];
s^a q[0];
cx^b q[1], q[0];
cz^a*b q[0], q[1];
s^-a*b**2 q[1];
