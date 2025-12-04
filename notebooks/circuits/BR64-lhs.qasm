OPENQASM 2.0;
include "qelib1.inc";
quditdim 23
qreg q[3];
cz q[1], q[2];
swap q[0], q[1];
cz^-b q[0], q[1];
h^-1 q[2];
s^-c q[2];
h^-1 q[2];
s^-cinv q[2];
h^-1 q[2];
s^{-c*(d + 1)} q[2];
h q[2];
swap q[1], q[2];
cz^-1 q[1], q[2];
