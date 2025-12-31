OPENQASM 2.0;
include "qelib1.inc";
quditdim 37
qreg q[3];
cz^-ac q[0], q[1];
cz^ac q[1], q[2];
h^3 q[0];
h q[1];
cx q[1], q[0];
