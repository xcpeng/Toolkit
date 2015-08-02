%----------------
%This file can generate big pictures from a long images

im = imread('C:\Users\xpeng\desktop\1.jpg');

[h,w,pp] = size(im);
h=double(h);
w=double(w);
ratio = 360/w;
im = imresize(im, ratio,'bilinear');

size_t=double(size(im))

j=1;
page = zeros(950,740,3)+255;

for i=1:size_t(1)
    lr=floor(i/950);
    if mod(lr,2)==0
        page(j,1:360,:)=im(i,:,:);
        j=j+1;
    else
        page(j,381:740,:)=im(i,:,:);
        j=j+1;
    end
    if j==950
        j=1;
    end
    if mod(i,950*2)==0
        page=uint8(page);
        imwrite(page,[ 'C:\Users\xpeng\desktop\' mat2str(i)  '.jpg'],'jpg');
        page = zeros(950,740,3)+255;
    end
    
end
 page=uint8(page);
 imwrite(page,[ 'C:\Users\xpeng\desktop\' mat2str(i)  '.jpg'],'jpg');
