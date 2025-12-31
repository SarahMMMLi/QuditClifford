OPENQASM 2.0;
include "qelib1.inc";
quditdim 37
qreg q[2];
h q[1];
cx q[1], q[0];
h q[0];
h^3 q[1];
cz^-a q[0], q[1];
s^a q[0];
s^a q[1];
h^3 q[0];
h q[1];
