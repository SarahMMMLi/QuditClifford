OPENQASM 2.0;
include "qelib1.inc";
quditdim 23
qreg q[1];
h^2 q[0];
s q[0];
h^2 q[0];
s^22 q[0];
