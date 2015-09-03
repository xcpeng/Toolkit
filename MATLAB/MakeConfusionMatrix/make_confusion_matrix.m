%This file is an example to show how to make confusion matrix
%First we will need two vectors, one is the ground truth vector
%the other one is the output vector.

%We use plotconfusion() to make the confusion matrix, C is the 
%final confusion matrix
[C, index] = plotconfusion(gt_labels, labels);

imagesc(C); 
% imagesc() will scale image data to the full range of current 
% colormap

colorbar;
