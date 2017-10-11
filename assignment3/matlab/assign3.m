load ocrfeaturestrain
% Since you need apparently the values for only C and O in assignment .
alfabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'; % taken from 

indexYOfCO = (Y == 3 | Y == 15); % Index for all values with just C and O

X = X(:, indexYOfCO);
Y = Y(:, indexYOfCO);
