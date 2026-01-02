OPENQASM 2.0;
include "qelib1.inc";
quditdim 37
qreg q[2];
cx^-1 q[0], q[1];
cx q[1], q[0];
cx^-1 q[0], q[1];
h^2 q[1];
