clear all;close all;clc;
load ocrsegments
Y = y;
filesize = size(S,2);
X = [];

for i = 1:filesize
   x = segment2features(S{i});
   X = [X x];
end % Convert everything so it can be properly used with our methods

[classification_data] = class_train(X, y);

filename = 'classification_data'; 
save(filename, 'classification_data');

short1 = '../datasets/short1';
short2 = '../datasets/short2';
home1 = '../datasets/home1';
home2 = '../datasets/home2';
home3 = '../datasets/home3';

datadirs = strings(1,5);
datadirs(1) = short1;
datadirs(2) = short2;
datadirs(3) = home1;
datadirs(4) = home2;
datadirs(5) = home3;

for dir = datadirs
    disp("Running test on " + dir);
    datadir = char(dir);
    
    inl4_test_and_benchmark
    errorVal = (1-hitrate)
end