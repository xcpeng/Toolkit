function Conf()
%Configuration of the deploy file, caffemodel, etc.

%define the deploy file
model_def_file = './model/deploy.prototxt';
model_file ='./model/finetune_car_full_iter_0.001_100k';

if caffe('is_initialized') == 0
  if exist(model_file, 'file') == 0
    % NOTE: you'll have to get the pre-trained ILSVRC network
    error('You need a network model file');
  end
  if ~exist(model_def_file,'file')
    % NOTE: you'll have to get network definition
    error('You need the network prototxt definition');
  end
  % load network in TEST phase
  %======core sentence===
  caffe('init', model_def_file, model_file, 'test')
end
fprintf('Done with init\n');
caffe('set_mode_gpu');
fprintf('Done with set_mode\n');
end