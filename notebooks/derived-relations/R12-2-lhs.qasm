OPENQASM 2.0;
include "qelib1.inc";
quditdim 37
qreg q[2];
h q[1];
cz q[0], q[1];
