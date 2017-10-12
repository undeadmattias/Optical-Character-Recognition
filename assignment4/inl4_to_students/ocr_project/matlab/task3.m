close all;
clear all;

P1 = [3 2 1 0; 2 2 2 0;2 1 2 1];
P2 = [1 2 2 3;1 1 0 2;3 1 2 0];
F = [-4 2 -6; 3 0 7; -6 9 1];

a1 = [1 2 1];
a2 = [3 2 1];
a3 = [0 3 1];

b1 = [1 1 1];
b2 = [5 1 1];
b3 = [-1 -3 1];

a1b1 = a1*F*b1' == 0
a1b2 = a1*F*b2' == 0
a1b3 = a1*F*b3' == 0

a2b1 = a2*F*b1' == 0
a2b2 = a2*F*b2' == 0
a2b3 = a2*F*b3' == 0

a3b1 = a3*F*b1' == 0
a3b2 = a3*F*b2' == 0
a3b3 = a3*F*b3' == 0