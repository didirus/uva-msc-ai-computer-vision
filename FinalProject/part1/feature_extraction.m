function [ D ] = feature_extraction(imageset, d_ims, sampler, descr_type, descr_step_size)

    % Define the 4 classes
    classes = {'airplanes','motorbikes','faces','cars'};
    
    % For every image, get the descriptors according to the descriptor type
    D = [];
    for i=1:length(classes)
        filename = char(strcat(imageset, classes(i), '_train/' ));
        
        % Use 250 images for the descriptors
        for j = 1:d_ims
            
            % Print the progress of the descriptor
            if j == 1
                disp(strcat('class ', num2str(i), '..'))
            end
            
            imagename = strcat(filename,'img',num2str(j,'%.3d'),'.jpg');
            I = imread(imagename);
            
            % Get the descriptors
            [~, d] = descriptors(single(I), sampler, descr_type, descr_step_size);
            D = vertcat(D,d');
        end
    end
end

