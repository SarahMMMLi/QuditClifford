OPENQASM 2.0;
include "qelib1.inc";
quditdim 37
qreg q[2];
cx^-c q[0], q[1];
cx^binv q[1], q[0];
