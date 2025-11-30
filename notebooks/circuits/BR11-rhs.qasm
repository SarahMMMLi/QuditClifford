OPENQASM 2.0;
include "qelib1.inc";
quditdim 23
qreg q[2];
h^-1 q[0];
s^-b q[0];
h^-1 q[0];
s^-binv q[0];
h^-1 q[0];
s^-b*(d + 1) q[0];
h q[0];
h q[1];
s^binv q[1];
h q[1];
cz q[0], q[1];
h^2 q[1];
s^b q[1];
h q[1];
