% Least squares method
A = [x ; ones(1, size(x,2))]';
p = A\y';

linefit = @(x) p(1)*(x) + p(2);

plot(x,y,'x')
hold on;
fplot(linefit, [-0.1 0.4], 'g')

% Calculate the least square error for the line
leastSquareError = 0;
for i = size(x, 2)
    leastSquareError = leastSquareError + abs(y(i)-linefit(x(i)));
end

% Calculate the total least square error for the line
totalLeastSquareError = 0;

for i = 1:size(x, 2)
    totalLeastSquareError = totalLeastSquareError + distanceToLine(x(i) ,y(i) , p(1), -1, p(2))^2;
end

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

% Calculate the least square error the line1
leastSquareError1 = 0;
for i = size(x, 2)
    leastSquareError1 = leastSquareError1 + abs(y(i)-linefit1(x(i)));
end

% Calculate the total least square error for line1
totalLeastSquareError1 = 0;
for i = 1:size(x, 2)
    totalLeastSquareError1 = totalLeastSquareError1 + distanceToLine(x(i) ,y(i) , (-1)*a1/b1, -1, (-1)*c1/b1)^2;
end

function l = distanceToLine(x, y, a, b, c)
    l = abs(a*x + b*y + c)/sqrt(a^2 + b^2);
end
