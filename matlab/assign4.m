clear all
load ocrsegments
Y = y;
images = size(S,2);
X = [];

for i = 1:images
   x = segment2features(S{i});
   X = [X x];
end
 
[classification_data] = class_train(X, Y);

filename = 'classification_data';
save(filename, filename);
