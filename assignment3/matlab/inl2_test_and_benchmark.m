%% This is a testscript for testing your function im2segmen.m
% inl2_test_and_benchmark
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
% From Assignment 1, you should have constructed
% a function
%   im2segment.m
% in the matlab folder.
% For this assignment you should construct a function
%   segment2features.m
% 
% This script could then be used to test if your function works.
% 

%% Setup the names of the functions of your OCR system.

mysystem.segmenter = 'im2segment'; % What is the name of your segmentation-algorithm.
mysystem.features = 'segment2features'; % What is the name of your features-algorithm.

%% Choose dataset
datadir = '../datasets/short1';     % Which folder of examples are you going to test it on

%% Benchmark and visualize
mode = 2; % debug mode with the most plots
[alljs,alljfg,allX,allY]=benchmark_inl2(mysystem,datadir,0);

%%
alfabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
ylist = unique(allY);
for yid = ylist,
    ids = find(allY==yid);
    disp(['Studying the character ' alfabet(yid)]);
    disp(['There are ' num2str(length(ids)) ' examples in the database.']);
    disp(['The feature vectors for these are:'])
    allX(:,ids)
    pause;
end

%% DIMENSIONALITY REDUCTION
[u,s,v]=svd(allX);
allX_reduced = u(:,1:2)'*allX;
figure;
for kk = 1:size(allX,2);
    kk
    text(allX_reduced(1,kk),allX_reduced(2,kk),alfabet(allY(kk)))
    hold on;
    %pause;
end
axis([min(allX_reduced(1,:))-0.5 max(allX_reduced(1,:))+0.5 min(allX_reduced(2,:))-0.5 max(allX_reduced(2,:))+0.5])


