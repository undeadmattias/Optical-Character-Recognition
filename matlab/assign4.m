% Setup classification data for the benchmark test
load ocrsegments
procent = 0.1
Y = y % Can be removed just added so we can use assignment 2 on it. 
filesize = size(S,2);
X = []
for i = 1:filesize
   x = segment2features(S{i})  
   X = [X x];
end

 part= cvpartition(100,'HoldOut',procent); % 80 % of indexes for classifcation 20 % of indexes for testing the method on. 
 train_set = part.training; % One at every index used for training (random selection)
   
train_set_indexes = find(train_set == 1); % gets indexs for all random training sets
    
    
train_set_values = X(:, train_set_indexes'); % Gets all the testing columns for X. 361 x 160
    
   
    
[classification_data] = class_train(train_set_values, y(:, train_set_indexes'));

%classification_data = cell(1,2);
%classification_data{1} = S;
%classification_data{2} = y;

filename = 'classification_data';
save(filename, 'classification_data');

