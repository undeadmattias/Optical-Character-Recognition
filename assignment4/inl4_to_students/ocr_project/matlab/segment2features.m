function features = segment2features(I)
% Cut out the part of the image that has only black pixels
% This way, the feature does not depend on which position it has
I = I(any(I,2), any(I,1));

height = size(I,1);
width = size(I,2);
pixels = height*width;

midHeight = floor(height/2);
midWidth = floor(width/2);

topHalf = I(1:midHeight, 1:width);
bottomHalf = I(midHeight+1:height, 1:width);
leftHalf = I(1:height, 1:midWidth);
rightHalf = I(1:height, midWidth+1:width);

topLeft = I(1:midHeight, 1:midWidth);
topRight = I(1:midHeight, midWidth+1:width);
bottomLeft = I(midHeight+1:height, 1:midWidth);
bottomRight = I(midHeight+1:height, midWidth+1:width);

% Total number of white pixels
% Could also be used to determine capital letters in the future perhabs
feature1 = sum(I(:,1));

% Percentage of the pixels that are white
feature2 = sum(sum(I()))/pixels*100;

% Percentage of the pixels that are white in the four regions of the image
feature3 = sum(sum(topHalf))/pixels*100;
feature4 = sum(sum(bottomHalf))/pixels*100;
feature5 = sum(sum(leftHalf))/pixels*100;
feature6 = sum(sum(rightHalf))/pixels*100;

feature7 = sum(sum(topLeft))/pixels*100;
feature8 = sum(sum(topRight))/pixels*100;
feature9 = sum(sum(bottomLeft))/pixels*100;
feature10 = sum(sum(bottomRight))/pixels*100;

% Sum pixels in rows
feature11 = sum(I(1,:));
feature12 = sum(I(:,1));
feature13 = sum(I(:,width));
feature14 = sum(I(height,:));


features = [feature1, feature2, feature3, feature4, feature5, feature6, feature7, feature8, feature9, feature10, feature11, feature12, feature13, feature14]';