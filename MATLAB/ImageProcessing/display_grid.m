function res = display_grid(root_dir, output_dir,varargin)
%display_grid(root_dir, varargin)
%generate a image grid

%keys can be passed in:
%	width			Width of each sub-image
%	height			Height of each sub-image
% 	ext				Ext of images
%	num_x			Number of images for each row
%	num_y			Number of images for each column
%	interval		Number of pixes between each sub-image
% 	int_pix_value	Pix value for interval patches 
%	seq_id			Sequence ID for batch generation


% AUTORIGHTS
% ---------------------------------------------------------
% Copyright (c) 2015, Xingchao Peng
% 
% This file is a part of image processing tools developed by
% Xingchao Peng. If you use it for your project, please re-
% tain this notification. Thank you!
% ---------------------------------------------------------


ip = inputParser;
ip.addRequired('root_dir', @isstr);
ip.addRequired('output_dir', @isstr);
ip.addOptional('width', 160 , @isscalar);
ip.addOptional('height', 120, @isscalar);
ip.addOptional('ext', 'jpg', @isstr);
ip.addOptional('num_x', 5, @isscalar);
ip.addOptional('num_y', 4, @isscalar);
ip.addOptional('interval', 5 , @isscalar);
ip.addOptional('int_pix_value', 128, @isscalar);
ip.addOptional('seq_id', '0', @isstr);

if length(varargin) == 0;
	ip.parse(root_dir, output_dir);
else
	ip.parse(root_dir, output_dir, varargin(:));	
end
opts = ip.Results;


image_style = [root_dir '/*.' opts.ext];
image_list 	= dir(image_style);
output_width = opts.interval*(opts.num_x-1) + opts.width * opts.num_x;
output_height = opts.interval *(opts.num_y - 1) + opts.height * opts.num_y;
output_image = zeros(output_height, output_width, 3);
output_image = output_image + opts.int_pix_value;
output_image = uint8(output_image);
x=0;
y=0;

for i =1:length(image_list)
	img = imread([root_dir '/' image_list(i).name]);
	if ndims(img) < 3
		[w,h] = size(img);
		tmp_img = zeros(w,h,3);
		tmp_img(:,:,1) = img;
		tmp_img(:,:,2) = img;
		tmp_img(:,:,3) = img;
		img = tmp_img;
	end
	img = imresize(img, [opts.height, opts.width], 'cubic');
	x = mod(i-1, opts.num_x);
	y = floor((i-1)/opts.num_x);
	y_start = y*(opts.height + opts.interval);
	x_start = x*(opts.width + opts.interval);
	output_image (y_start+1:y_start+opts.height, x_start+1:x_start+opts.width, :) = img(:,:,:); 
end
imwrite(output_image, [output_dir '/output_image_' opts.seq_id '.png'], 'png');
end
