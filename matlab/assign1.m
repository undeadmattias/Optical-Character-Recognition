% Script Least squares method
ettorna = ones(1, size(x,2))
A = [x ; ettorna]'
p = A\y'


line = @(x) p(1)*(x) + p(2);

plot(x,y,'x')
hold on;
fplot(line, [-0.1 0.4])

%% Total least square method (Test not real one)
xtak11 = sum(x.*x)
xtak12 = sum(x.*y)
xtak13 = sum(x)

xtak21 = xtak12;
xtak22 = sum(y.*y);
xtak23 = sum(y);

xtak31 = xtak13;
xtak32 = xtak23;
xtak33 = size(x,2);

xtak = [xtak11 xtak12 xtak13; xtak21 xtak22 xtak23; xtak31 xtak32 xtak33];

[V, D] = eig(xtak)



%% total least square version 0.2
N = size(x, 2);
m11 = sum(x.*x) - (1/N)*sum(x)*sum(x)
m12 = sum(x.*y) - (1/N)*sum(x)*sum(y)

m21 = m12;
m22 = sum(y.*y) - (1/N)*sum(y)*sum(y)



m = [m11 m12 ; m21 m22]

[V, D] = eig(m)

a1 = V(1, 1)
a2 = V(1, 2)

b1 = V(2, 1)
b2 = V(2, 2)

c1 = -(1/N)*(a1*sum(x) + b1*sum(y))
c2 = -(1/N)*(a2*sum(x) + b2*sum(y))

line1 = @(x) -1*(a1*x + c1) /b1;
line2 = @(x) -1*(a2*x + c2) /b2;

plot(x,y,'x')
hold on;
fplot(line1, [-0.1 0.4], 'r')
fplot(line2, [-0.1 0.4], 'b')
%axis([-1 1 -1 1]);






