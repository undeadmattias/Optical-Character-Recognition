function [S] = im2segment(im)
  threshold = 110; % The threshold for determining if the pixel should be 
                   % black or white

  nrofsegments = 5;
  m = size(im,1); % Rows
  n = size(im,2); % Columns

  S = cell(1,nrofsegments);

  for kk = 1:nrofsegments

      image = im;
      
      % Determine the interval in which the current character exists
      endRow = 1;
      letterNumber = kk;
      while letterNumber > 0
          startRow = findNextLetterRow(image, endRow, m, n, threshold);
          endRow = findNextWhiteRow(image, startRow, m, n, threshold);
          letterNumber = letterNumber - 1;
      end

      % Fill all the area outside the interval with black pixels and
      % invert the colors
      image = invertColor(image, threshold);
      image = fillBlack(image, 1, startRow-1);
      image = fillBlack(image, endRow, n);

      % Put the letter image in the right position
      S{kk} = image;
  end

end

%% Help functions

% Starting for a startIndex row, will find the next row in an image that 
% has a row of only pixels above a threshold value (white pixels)
function row = findNextWhiteRow(image, startIndex, rows, cols, threshold)
    for y = startIndex:cols
        whiteRow = true;
         for x = 1:rows
             if image(x,y) < threshold
                 whiteRow = false;
                 break
             end
         end

         if whiteRow
            row = y;
             break
         end
    end
    row = y;
end

% Starting for a startIndex row, will find the next row in an image that 
% has a row of a pixels under a threshold value (black pixels). This
% indicates that a character is on that row and the row will be returned.
function row = findNextLetterRow( image, startIndex, rows, cols, threshold )
     for y = startIndex:cols
          for x = 1:rows
              pixel = image(x,y);
              if (pixel < threshold)
                  row = y;
                  return
              end
          end
     end
     row = cols;
end

% Will take an black and white image and invert the colors.
function image = invertColor(input, threshold)

    for y = 1:size(input,2)
         for x = 1:size(input,1)
             pixel = input(x,y);
              if pixel < threshold
                  input(x,y) = 1;
              else
                  input(x,y) = 0;
              end
         end
    end

    image = input;
end

% Will overwrite an image with black pixels within an interval
function image = fillBlack(image, startIndex, stopIndex)
    for y = startIndex:stopIndex
         for x = 1:size(image,1)
             image(x,y) = 0;
         end
    end
end

