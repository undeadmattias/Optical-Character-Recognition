close all
clc

% Setup task and settings
load femfel.mat
pictureNumber = 3;
filterSize = 15;
thresholdValue = 45;
image1a = femfel1(:,:,:);
image1b = femfel2(:,:,:);

filter = (1/((filterSize^2)*3)).*ones(filterSize, filterSize, 3);

filteredImage1a = convn(image1a, filter, 'same');
filteredImage1b = convn(image1b, filter, 'same');

image1Diff = abs(filteredImage1a - filteredImage1b) > thresholdValue;
% imagesc(abs(filteredImage1a - filteredImage1b))
figure()
imagesc(image1Diff)