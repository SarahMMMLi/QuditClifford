OPENQASM 2.0;
include "qelib1.inc";
quditdim 37
qreg q[2];
cx q[0], q[1];
cx^-binv*c q[1], q[0];
h q[0];
s^t q[0];
h q[0];
s^tinv q[0];
h q[0];
s^t q[0];
h q[0];
s^binv q[0];
h q[0];
s^binvinv q[0];
h q[0];
s^binv q[0];
