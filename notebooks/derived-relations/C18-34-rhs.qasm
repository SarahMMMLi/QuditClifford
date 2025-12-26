OPENQASM 2.0;
include "qelib1.inc";
quditdim 37
qreg q[3];
cx^a q[2], q[1];
cx^b q[1], q[0];
cx^-a*b q[2], q[0];
