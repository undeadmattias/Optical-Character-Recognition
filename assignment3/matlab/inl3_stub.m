alfabet = 'abcdefghijklmnopqrstuvwxyz';
datadir = '../datasets/short1';

a = dir(datadir);

file = 'im2';

fnamebild = [datadir filesep file '.jpg'];
fnamefacit = [datadir filesep file '.txt'];

bild = imread(fnamebild);
fid = fopen(fnamefacit);
facit = fgetl(fid);
% % fclose(fid);

% Load the data from the training of the classifier
load classification_data


%% Try out the segmentation
S = im2segment(bild);
% followed by feature extraction for one of the segments
B = S{1};
x = segment2features(B);
% followed by classification of the feature
y = features2class(x,classification_data);
y
alfabet(y)
%%
if 1,
    figure(1); colormap(gray);
    for k = 1:1;
        imagesc(S{k});
        title(['Classified as class nr: ' num2str(y) ' which corresponds to the character ' upper(alfabet(y))]);
        %disp('tryck på en tangent');
        %pause;
    end;
end;
