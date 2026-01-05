OPENQASM 2.0;
include "qelib1.inc";
quditdim 37
qreg q[2];
h q[1];
s^t q[1];
h q[1];
s^tinv q[1];
h q[1];
s^t q[1];
h q[1];
s^binv q[1];
h q[1];
s^binvinv q[1];
h q[1];
s^binv q[1];
cx^-binv*c q[1], q[0];
cx q[0], q[1];
