startup;
Conf();
cars_annotations_ld = load('./data/cars_annos.mat');
annotations=cars_annotations_ld.annotations;
labels = cars_annotations_ld.class_names;
image_dir = './data/car_ims_50/';
num_images = 415;
feature_dim = 4096;
features = zeros(num_images,feature_dim);
sub_labels = cell(num_images,1);

iter=1;
for i=1:length(annotations)
    
    if annotations(i).test==1 && annotations(i).class>11 && annotations(i).class<22
        [path file ext] = fileparts(annotations(i).relative_im_path);
        img = imread([image_dir '/' file ext]);
	if size(size(img),2)<3
		continue;
	end
	
	fprintf('Processing %s\n', file);
        scores = extractor(img);
        scores = mean(squeeze(scores),2)';
        features(iter,:) = scores;
	sub_labels{iter} = labels{annotations(i).class};
        iter=iter+1; 
    end
end
features = features(1:iter-1, :);
size(sub_labels)
iter 
sub_labels = {sub_labels{1:iter-1}}';
save('sub_labels.mat', 'sub_labels');
%save('l_features.mat', 'features');
