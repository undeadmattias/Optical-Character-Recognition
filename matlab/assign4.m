clear all
load ocrsegments
Y = y;
images = size(S,2);
X = [];
for i = 1:images
   x = segment2features(S{i});
   X = [X x];
end

part= cvpartition(100,'HoldOut', 0.2);
   
trainSetIndex = find(part.training == 1);
trainSetValues = X(:, trainSetIndex');
 
[classification_data] = class_train(trainSetValues, y(:, trainSetIndex'));

filename = 'classification_data';
save(filename, filename);
