%% This is a testscript for testing your function im2segmen.m
% inl3_test_and_benchmark
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

mysystem.segmenter = 'im2segment_good2'; % What is the name of your segmentation-algorithm.
mysystem.features = 'segment2features2'; % What is the name of your features-algorithm.
mysystem.classifier = 'features2class'; % What is the name of your classification-algorithm.
load classification_data
mysystem.classification_data = classification_data;

%% Choose dataset
datadir = '../datasets/short1';     % Which folder of examples are you going to test it on
%datadir = '../datasets/home2';     % Which folder of examples are you going to test it on

%% Benchmark and visualize
mode = 0; % debug modes 
% 0 with no plots
% 1 with some plots
% 2 with the most plots
[hitrate,confmat,allres,alljs,alljfg,allX,allY]=benchmark_inl3(mysystem,datadir,mode);

hitrate

