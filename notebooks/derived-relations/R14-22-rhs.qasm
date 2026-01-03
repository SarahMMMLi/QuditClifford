OPENQASM 2.0;
include "qelib1.inc";
quditdim 37
qreg q[2];
h^-1 q[1];
s^binv q[1];
h^-1 q[1];
s^b q[1];
h q[1];
s^b*t**2 q[0];
cx^b*t q[0], q[1];
cz^-t q[0], q[1];
