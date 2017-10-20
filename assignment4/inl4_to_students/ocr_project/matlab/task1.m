close all
clear all
clc

% Setup task and settings
load femfel.mat
pictureNumber = 3;
filterSize = 10;
thresholdValue = 70;
image1a = femfel1(:,:,:);
image1b = femfel2(:,:,:);

% Convolute the images with a filter of ones to take a median pixel value
% over a group of pixels
filter = (1/((filterSize^2)*3)).*ones(filterSize, filterSize, 3);

filteredImage1a = convn(image1a, filter, 'same');
filteredImage1b = convn(image1b, filter, 'same');

figure();
image(uint8(filteredImage1a));
figure();
imshow(uint8(filteredImage1b));

% Remove pixels with a value lower than the threshold
image1Diff = abs(filteredImage1b - filteredImage1a) > thresholdValue;

figure()
imagesc(image1Diff)
