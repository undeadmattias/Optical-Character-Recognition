function [S] = im2segment(im)
    m = size(im,1); % row size
    n = size(im,2); % column size

    imgCount = 1;
    imgFound = 0;

    imageConv = im < 140; % Every pixel less than 140 gets set to 1 and counts as black
 
for kk = 1:n
    %S{kk}= zeros(m, n);
    if sum(imageConv(:, kk)) > 0  % if there is at least one pixel that is black in the column
        if (imgFound == 0) % If looking for start index for image
            imgFound = kk; % Sets a start index
        end
    else
        
        if imgFound > 0 % If start index looking for end index
            result = zeros(m, n); % Fills result with zeros to begin with
            result(:, imgFound:kk-1) = imageConv(:, imgFound:kk-1); % The columns for a letter gets inserted into result
            S{imgCount}= result; % result is returned as the first letter with zeros everywhere else
            imgCount = imgCount + 1; % Increase letter count
            imgFound = 0; % looks for a new letter
        end
    end
end
