OPENQASM 2.0;
include "qelib1.inc";
quditdim 37
qreg q[3];
cz^b q[1], q[2];
cx^a q[0], q[2];
cz^a*b q[0], q[1];
