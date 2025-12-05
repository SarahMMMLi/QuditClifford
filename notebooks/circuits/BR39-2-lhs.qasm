OPENQASM 2.0;
include "qelib1.inc";
quditdim 23
qreg q[2];
cz q[0], q[1];
swap q[0], q[1];
cz^-b q[0], q[1];
