% This file is to parse the weights of CNN
% You should first load the weights of CNN


fid=fopen('net_size.txt','w');
load('C:\Users\xpeng\Desktop\x.mat');
for i =1:size(x)
    layer=x(i);
    fprintf(fid, 'Parsing layer %s\n',layer.layer_names);
    weights = layer.weights;
    for j=1:size(weights,1);
        weight= weights{j};
        weight = squeeze(weight);
        save(['weight' '_' mat2str(i) '_' mat2str(j) '.mat'],'weight');
    end
end
fclose(fid);