close all
clc

% Setup task and settings
load femfel.mat
pictureNumber = 3;
filterSize = 10;
thresholdValue = 70;
image1a = femfel1(:,:,:);
image1b = femfel2(:,:,:);


% imshow(image1a);
% figure()
% imshow(image1b);
% figure()
% imshow(abs(image1b - image1a));

filter = (1/((filterSize^2)*3)).*ones(filterSize, filterSize, 3);

filteredImage1a = convn(image1a, image1b, 'same');
filteredImage1b = convn(image1b, filter, 'same');

figure();
image(uint8(filteredImage1a));
figure();
imshow(uint8(filteredImage1b));

image1Diff = abs(filteredImage1b - filteredImage1a) > thresholdValue;
% imagesc(abs(filteredImage1a - filteredImage1b))
figure()
imagesc(image1Diff)

%Hallaasdad