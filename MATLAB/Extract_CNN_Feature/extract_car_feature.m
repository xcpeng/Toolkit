startup;

im=imread('1.jpg');
scores = extractor(im);
save('scores.mat','scores');