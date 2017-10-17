% Least squares method
A = [x ; ones(1, size(x,2))]';
p = A\y';

linefit = @(x) p(1)*(x) + p(2);

plot(x,y,'x')
hold on;
fplot(linefit, [-0.1 0.4], 'g')

%% Total least square
N = size(x, 2);
m11 = sum(x.*x) - (1/N)*sum(x)*sum(x);
m12 = sum(x.*y) - (1/N)*sum(x)*sum(y);

m21 = m12;
m22 = sum(y.*y) - (1/N)*sum(y)*sum(y);

m = [m11 m12 ; m21 m22];

[V, D] = eig(m);

a1 = V(1, 1);
a2 = V(1, 2);

b1 = V(2, 1);
b2 = V(2, 2);

c1 = -(1/N)*(a1*sum(x) + b1*sum(y));
c2 = -(1/N)*(a2*sum(x) + b2*sum(y));

linefit1 = @(x) -1*(a1*x + c1) /b1;
linefit2 = @(x) -1*(a2*x + c2) /b2;

plot(x,y,'x')
hold on;
fplot(linefit1, [-0.1 0.4], 'r')
fplot(linefit2, [-0.1 0.4], 'b')
