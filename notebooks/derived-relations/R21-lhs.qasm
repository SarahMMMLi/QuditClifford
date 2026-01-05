OPENQASM 2.0;
include "qelib1.inc";
quditdim 37
qreg q[2];
cx q[0], q[1];
cx^y q[1], q[0];
h q[0];
s^yplus1 q[0];
h q[0];
s^yplus1inv q[0];
h q[0];
s^yplus1 q[0];
