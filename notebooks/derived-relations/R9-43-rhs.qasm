OPENQASM 2.0;
include "qelib1.inc";
quditdim 37
qreg q[2];
h^2 q[0];
cx^-a q[0], q[1];
