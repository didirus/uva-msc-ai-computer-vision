function visualize_net(network, data, type_of_net)
network.layers{end}.type = 'softmax';
label = [];
feats = [];

for j = 1:size(data.images.data,4)
    
    result = vl_simplenn(network, data.images.data(:, :,:, j));
    feat = result(end-3).x;
    feat = squeeze(feat);
    
    if (data.images.set(j) ~= 1)
        feats = [feats feat];
        label   = [label;  data.images.labels(j)];
    end
    
    
end

out_tsne = tsne(double(feats'), double(label));
figure();
gscatter(out_tsne(:,1),out_tsne(:,2), label);
title(type_of_net)



end
