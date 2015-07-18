%This Plot shows how to set upbound and lower bound of the plot the make
%the plot more beautiful


ap1 = zeros(7, 1);
ap2 = zeros(7, 1);
ap1 = ap1 + 20;
ap2 = ap2 + 30;
data=[0, 400, 800, 1200, 1600, 2000, 2700];
test=[400, 800, 1200, 1600, 2000, 2400];
ap=[26.7,26.09,28.01,28.57,28.9,28.63];

plot(data,ap1,'k',data,ap2,'k',test,ap,':o');
for i=1:length(test)
    text(test(i)-50,ap(i)-1.2,mat2str(ap(i)));
end

xlabel('Number of training images');
ylabel('mAP');

