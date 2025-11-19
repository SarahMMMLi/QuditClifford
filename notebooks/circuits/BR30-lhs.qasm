OPENQASM 2.0;
include "qelib1.inc";
quditdim 23
qreg q[2];
s q[1];
swap q[0], q[1];
