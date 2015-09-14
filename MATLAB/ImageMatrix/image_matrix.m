%base='C:\Users\305\Desktop\3d model\pascal\';
base='C:\Users\305\Desktop\img\';
a=dir([base '*.jpg']);
interval=25;
per_w = 160;
per_h = 120;
num_x = 6;
num_y = 3;% 5*3 subplot
width  = interval*(num_x-1) + num_x*per_w;
height = interval*(num_y-1) + num_y*per_h;

image=zeros(height, width,3);
image=image+50;
image=uint8(image);
%imshow(image);

x=0;
y=0;
for i=1:length(a)
    [base a(i).name]
    im = imread([base a(i).name]);
    im = imresize(im,[per_h,per_w],'cubic');
   imshow(im);
    x=mod(i-1,num_x);     %co
    y=floor((i-1)/num_x); %row
    y_start=y*(per_h+interval);
    x_start=x*(per_w+interval);
 
 
    %image(1:1+per_h-1,1:1+per_w-1,:)=im(:,:,:);
    image(y_start+1:y_start+per_h,x_start+1:x_start+per_w,:)=im(:,:,:);
    
end
imshow(image);
imwrite(image,[base 'office.png'],'png');