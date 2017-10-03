% Setup classification data for the benchmark test
load ocrsegments

filesize = size(S,2);

% [classification_data] = class_train(S, y);

classification_data = cell(1,2);
classification_data{1} = S;
classification_data{2} = y;

filename = 'classification_data';
save(filename, 'classification_data');

