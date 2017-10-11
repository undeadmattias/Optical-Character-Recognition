% Graph cuts
load heart_data
hold on

mu = mean(background_values);
sigma = std(background_values);

x = (-5 * sigma:0.01:5 * sigma) + mu;  %// Plotting range
y = exp(- 0.5 * ((x - mu) / sigma) .^ 2) / (sigma * sqrt(2 * pi));
plot(x, y, 'b')

mu = mean(chamber_values);
sigma = std(chamber_values);

x = (-5 * sigma:0.01:5 * sigma) + mu;  %// Plotting range
y = exp(- 0.5 * ((x - mu) / sigma) .^ 2) / (sigma * sqrt(2 * pi));

plot(x, y, 'r')

% Plotting the gaussian distributions
% The blue is the background and the red is the chamber class
