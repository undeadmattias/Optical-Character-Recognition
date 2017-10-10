function [S] = im2segment(im)
% [S] = im2segment(im)

nrofsegments = 4;
m = size(im,1);
n = size(im,2);
for kk = 1:nrofsegments;
    S{kk}= (rand(m,n)<0.5);
end;
