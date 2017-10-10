function text = ocr(im,mysystem);
% text = ocr(im,mysystem) - OCR system that takes an image (im)
%    as input and produce a text string (text) as output.
% In the variable mysystem is specified which segmenter, feature
% extraction and classifier to use, as well as what classification
% data was obtained from training. 

S = feval(mysystem.segmenter,im);
nrofsegments = length(S);
text = char(zeros(1,nrofsegments));
alfabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
clear f;
for k = 1:nrofsegments;
    % For each segment ...
    % ... calculate the feauture vector ...
    x = feval(mysystem.features,S{k});
    % ... do the classification ...
    y = feval(mysystem.classifier,x,mysystem.classification_data);
    % ... and convert from classes y (1, ..., 26) to character (A, ..., Z)
    text(k)=alfabet(y); 
end
