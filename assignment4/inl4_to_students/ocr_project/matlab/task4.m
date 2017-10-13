clear all;
load ocrsegments
Y = y % Can be removed just added so we can use assignment 2 on it. 
filesize = size(S,2);
X = []
for i = 1:filesize
   x = segment2features(S{i})  
   X = [X x];
end % Convert everything so it can be properly used with our methods

[classification_data] = class_train(X, y);

filename = 'classification_data';
save(filename, 'classification_data');
inl4_test_and_benchmark
errorVal = (1-hitrate)