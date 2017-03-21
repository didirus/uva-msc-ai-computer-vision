function [ X ] = get_features(imageset, vocab_size, centers, descr_type, set)
    
    classes = {'airplanes','motorbikes','faces','cars'};
    
    if strcmp(set, 'train')
        start_im_ind = 251;
        images_per_class = 100;
        dir_name = '_train';
    elseif strcmp(set, 'test') 
        start_im_ind = 1;
        images_per_class = 50;
        dir_name = '_test';
    end

    row_dims = images_per_class * length(classes);
    
    % For every image, get the descriptors, do quantization
    X = zeros(row_dims, vocab_size); % features frequencies
    
    % Repeat for each class
    ind = 1;
    for i=1:length(classes)
        filename = char(strcat(imageset, classes(i), dir_name, '/'));
        for j = start_im_ind : start_im_ind+images_per_class-1 
            imagename = strcat(filename,'img',num2str(j,'%.3d'),'.jpg');
            I = imread(imagename);
            
            % Get the descriptors
            [~, d] = descriptors(I, descr_type);
            
            % Check d should be transpose?
            % Get feature frequencies for SVM
            freqs = quantize(centers, d, vocab_size);

            % Check if frequency should be transpose?
            freqs = freqs';
            X(ind,:) = freqs;
        
            ind = ind + 1;
            
        end
    end
end
