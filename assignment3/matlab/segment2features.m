function features = segment2features(I)
% features = segment2features(I)

% Removes all the rows/columns without text pixels

newColFound = 0;
fcountcol = 0;
for i = 1:size(I,2)
    
    if (sum(I(:, i)) > 8 && newColFound == 0)
        fcountcol = fcountcol + 1;
        newColFound = 1;
    else
        newColFound = 0;
    end
end

newRowFound = 0;
fcountrow = 0;

for i = 1:size(I,1)
   
    if (sum(I(i, :)) > 8 && newRowFound == 0)
        fcountrow = fcountrow + 1;
        newRowFound = 1;
    else
        newRowFound = 0;
    end
end

OriginalIletter = I(any(I,2),any(I,1)); 


Iletter = edge(OriginalIletter, 'canny');


% Ilettersize = size(Iletter);
% Ilettercolsize = Ilettersize(2);
% Iletterrowsize = Ilettersize(1);
% 
% if Ilettercolsize > 18
%     Ilettercolsize = 18;
% if Iletterrowsize > 20
%     Iletterrowsize = 20;
%     
% tempIletter = zeros(18, 20);

% Resize the image to 18 by 20 to get the same amount of pixels for each
% interval
Iletter2 = imresize(OriginalIletter, [18 20]);
Iletter = imresize(Iletter, [18 20]);
% subplot(2,1, 1);
% imshow(OriginalIletter)
% subplot(2,1, 2);
% imshow(Iletter)
% pause;
%Iletter = zeros(18, 20)



% f1 = sum(sum(Iletter(1:3, 1:10))); 
% f2 = sum(sum(Iletter(4:6, 1:10))); 
% f3 = sum(sum(Iletter(7:9, 1:10))); 
% f4 = sum(sum(Iletter(10:12, 1:10))); 
% f5 = sum(sum(Iletter(13:15, 1:10))); 
% f6 = sum(sum(Iletter(16:18, 1:10))); 
% 
% f7 = sum(sum(Iletter(1:3, 11:20))); 
% f8 = sum(sum(Iletter(4:6, 11:20))); 
% f9 = sum(sum(Iletter(7:9, 11:20))); 
% f10 = sum(sum(Iletter(10:12, 11:20))); 
% f11 = sum(sum(Iletter(13:15, 11:20))); 
% f12 = sum(sum(Iletter(16:18, 11:20))); 
% 
% f13 = floor(sum(sum(Iletter)) / 10);
% 
% features = [1 f13 f12 f11 f10 f9 f8 f7 f6 f5 f4 f3 f2 f1]';

%Intervals
f1 = sum(sum(Iletter(1:6, 1:10))); 
f2 = sum(sum(Iletter(7:12, 1:10))); 
f3 = sum(sum(Iletter(13:18, 1:10))); 
f4 = sum(sum(Iletter(1:6, 11:20))); 
f5 = sum(sum(Iletter(7:12, 11:20))); 
f6 = sum(sum(Iletter(13:18, 11:20))); 


f7 = sum(sum(Iletter2(1:6, 1:10))); 
f8 = sum(sum(Iletter2(7:12, 1:10))); 
f9 = sum(sum(Iletter2(13:18, 1:10))); 
f10 = sum(sum(Iletter2(1:6, 11:20))); 
f11 = sum(sum(Iletter2(7:12, 11:20))); 
f12 = sum(sum(Iletter2(13:18, 11:20))); 

%teer = bweuler(itemp,1);
%f13 = regionprops(Iletter,'area');
%f133 = f13.Area;

%f14 = regionprops(Iletter,'convexarea');
%f144 = f14.ConvexArea;

%f15 = regionprops(Iletter,'Centroid');
%f155 = f15.Centroid;
%f1555 = f155(1);
%f15555 = f155(2);

features = [f1 f2 f3 f4 f5 f6 f7 f8 f9 f10 f11 f12 fcountcol fcountrow]'

% Iletteruniquerow = unique(Iletter,'rows');
% Iletteruniquecolumns = unique(Iletter','rows');
% 
% Iletteruniquerowcol = unique(Iletteruniquerow', 'rows');
% 
% %f1 = sum(sum(I)); % feature 1 just take sum of everything.
% f2 = sum(sum(Iletteruniquerow)); % unique rows count black
% f3 = sum(sum(Iletteruniquecolumns)); % unique columns count black. 
% 
% f4 = sum(sum(Iletteruniquerowcol)); % Take unique row and col
% 
% 
% 
% colsize = size(Iletter, 2)
% rowsize = size(Iletter, 1);
% 
% 
% %resizeI = imageimresize(Iletter, [5)
% 
% %iy = abs(conv2(I, dy, 'same'));
% 
% 
% 
%  dxxx = [1 -1];
%  dy = [1; -1];
%  %testingtest = conv2(Iletter, [1 -1]);
%     %iy = abs(conv2(Iletter, dxxx))
%  %I
%  %testere = dxxx + dyyy';
% %ixxeeed = sum(sum(abs(conv2(I, [1 -1], 'same'))))
%  %iy = abs(conv2(I, dy, 'same'));
% 
%  %f5 = sum(sum(ix + iy));
% %f5 = sum(sum(~Iletteruniquerow));
% %f6 = sum(sum(~Iletteruniquecolumns));
% 
% features = [1 1 f4 f3 f2 1]';
end



%features = randn(7,1);