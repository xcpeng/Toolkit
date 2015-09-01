startup;
Conf();
img = imread('1.jpg');

scores = extractor(img);
scores = mean(squeeze(scores),2)';

