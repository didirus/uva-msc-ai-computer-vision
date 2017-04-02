function [ X ] = get_input_features(imageset, d_ims, vocab_size, centers, sampler, descr_type, set, nr_images, descr_step_size)
    % This function returns the feature matrix of the images
    % It is made both for the train and test set, so therefore
    % we added some specific settings for both sets

    classes = {'airplanes','motorbikes','faces','cars'};
    
    if strcmp(set, 'train')
        start_im_ind = d_ims+1;
        dir_name = '_train';
    elseif strcmp(set, 'test') 
        start_im_ind = 1;
        dir_name = '_test';
    end

    row_dims = nr_images * length(classes);
    
    % For every image, get the descriptors, do quantization
    X = zeros(row_dims, vocab_size);
    
    % Repeat for each class
    ind = 1;
    for i=1:length(classes)
        
        % Get the imagefile
        filename = char(strcat(imageset, classes(i), dir_name, '/'));
        
        % Repeat for every image
        for j = start_im_ind : start_im_ind + nr_images - 1 
            imagename = strcat(filename,'img',num2str(j,'%.3d'),'.jpg');
            I = imread(imagename);
            
            % Get the descriptors
            [~, d] = descriptors(I, sampler, descr_type, descr_step_size);
            
            % Get feature frequencies for SVM
            freqs = quantize(centers, d, vocab_size);
            freqs = freqs';
            X(ind,:) = freqs;
            
            % Update the location index of the matrix
            ind = ind + 1; 
        end
    end
end
