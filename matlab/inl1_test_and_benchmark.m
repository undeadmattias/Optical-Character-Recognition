%% This is a testscript for testing your function im2segmen.m
% inl1_test_and_benchmark
% Make sure you have downloaded inl_ocr1.zip. 
% When you unzip it you should have a folder
%   ocr_project
% and in this folder there are two folders
%      datasets
%      matlab
% put your code for ocr in the matlab folder. 
% In the datasets folder there is for now only one
% folder 'short1'
% which contains a few test examples and ground-truth 
% both for segmentation and for recognition. 
% 
% Make sure you have written a function in a file im2segment.m
% in the matlab folder.
% 
% This script could then be used to test if your function works
% and benchmark how well it works. 

%% Setup the names of the functions of your OCR system.

mysystem.segmenter = 'im2segment'; % What is the name of your segmentation-algorithm.

%% Choose dataset
datadir = '../datasets/short1';     % Which folder of examples are you going to test it on

%% Benchmark and visualize
mode = 2; % debug mode with the most plots
[alljs,alljfg]=benchmark_inl1(mysystem,datadir,2);

%%

disp(['You tested ' num2str(size(alljs,1)) ' images in folder ' datadir]);
disp(['The jaccard scores for all segments in all images were']);
disp(alljs);

mjs = mean(alljs(:));
disp(['The mean of the jaccard scores were ' num2str(mjs)]);

if mjs > 0.95,
    disp('This is great!');
elseif mjs>0.9,
    disp('This is good!');
elseif mjs>0.8
    disp('You can do better');
elseif mjs>0.5
    disp('Try to make it better');
else
    disp('This is not good enough. I think there is a bug somewhere');
end
