OPENQASM 2.0;
include "qelib1.inc";
quditdim 37
qreg q[2];
h q[0];
cx q[0], q[1];
h^3 q[0];
