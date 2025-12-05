OPENQASM 2.0;
include "qelib1.inc";
quditdim 23
qreg q[2];
swap q[0], q[1];
cz^-bminus1 q[0], q[1];
