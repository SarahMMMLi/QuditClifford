OPENQASM 2.0;
include "qelib1.inc";
quditdim 37
qreg q[2];
h q[1];
s^yplus1 q[1];
h q[1];
s^yplus1inv q[1];
h q[1];
s^yplus1 q[1];
cx^y q[1], q[0];
cx q[0], q[1];
