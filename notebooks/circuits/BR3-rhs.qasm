OPENQASM 2.0;
include "qelib1.inc";
quditdim 37
qreg q[1];
h^-1 q[0];
s^-b q[0];
h^-1 q[0];
s^-binv q[0];
h^-1 q[0];
s^{-b*(1 - a)} q[0];
h q[0];
s^ainv*binv q[0];
