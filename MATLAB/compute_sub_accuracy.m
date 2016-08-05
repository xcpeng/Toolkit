%gt_label is the ground truth label
gt_label_ld = load('gt_shape_trainval_alex.mat');
gt_label = gt_label_ld.cat;
%feat_cache is the prediciton [n * dim]
feat_cache_ld = load('prediction_shape_trainval_alex.mat');
feat_cache = feat_cache_ld.feat_cache;

gt_label = gt_label +1;
[C, ind] = confusionmat(gt_label, feat_cache);

x_sum = sum(C);
C=double(C);
p = zeros(20,1);
for i =1:20
	p(i) = C(i, i) / x_sum(i);
end
