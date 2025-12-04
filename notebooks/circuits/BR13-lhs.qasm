OPENQASM 2.0;
include "qelib1.inc";
quditdim 23
qreg q[2];
cz q[0], q[1];
h^-1 q[1];
s q[1];
h^-1 q[1];
s q[1];
h^-1 q[1];
s^{b + 1} q[1];
h q[1];
swap q[0], q[1];
