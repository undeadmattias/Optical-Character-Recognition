% Graph cuts
clear all;
close all;
load heart_data
hold on

%% Part A of the assignment
% Finding the values for gaussian distribution for background- and chamber
% pixels
background_mu = mean(background_values);
background_sigma = std(background_values);

chamber_mu = mean(chamber_values);
chamber_sigma = std(chamber_values);

background_x = (-5 * background_sigma:0.01:5 * background_sigma) + background_mu;  %// Plotting range
background_y = exp(- 0.5 * ((background_x - background_mu) / background_sigma) .^ 2) / (background_sigma * sqrt(2 * pi));

chamber_x = (-5 * chamber_sigma:0.01:5 * chamber_sigma) + chamber_mu;  %// Plotting range
chamber_y = exp(- 0.5 * ((chamber_x - chamber_mu) / chamber_sigma) .^ 2) / (chamber_sigma * sqrt(2 * pi));

% Plotting the gaussian distributions
% The blue is the background and the red is the chamber class
plot(background_x, background_y, 'b')
plot(chamber_x, chamber_y, 'r')

%% B part of the assignment
prob_background = size(background_values)/(size(background_values)+size(chamber_values)); % P(Y1)
prob_chamber = 1 - prob_background; % P(Y2)

imageWidth = size(im, 1); % M
imageHeight = size(im, 2); % N
numberOfPixels = imageHeight * imageWidth;

Neighbours = edges4connected(imageWidth, imageHeight);
i = Neighbours(:,1);
j = Neighbours(:,2);
A = sparse(i, j, 0.1, numberOfPixels, numberOfPixels);

[X,Y] = ndgrid(1:imageWidth,1:imageHeight);
% draw_graph(X(:),Y(:),A); % This operation drains computer power for such
% large images as this one

% Set A to lambda?


T = [ (im(:)-chamber_mu).^2 (im(:)-background_mu).^2];
T = sparse(T);
tic
[E, Theta] = maxflow(A,T);
Theta = reshape(Theta ,imageWidth, imageHeight);
Theta = double(Theta);
toc

imshow(Theta)
figure
imshow(im)
disp('Approve this please')

