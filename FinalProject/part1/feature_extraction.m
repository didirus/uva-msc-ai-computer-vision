function [ D ] = feature_extraction(imageset, d_ims, descr_type,descr_step_size)

    % Define the 4 classes
    classes = {'airplanes','motorbikes','faces','cars'};
    
    % For every image, get the descriptors according to the descriptor type
    D = [];
    for i=1:length(classes)
        filename = char(strcat(imageset, classes(i), '_train/' ));
        
        % Use 250 images for the descriptors
        for j = 1:d_ims
            
            imagename = strcat(filename,'img',num2str(j,'%.3d'),'.jpg');
            I = imread(imagename);
            
            % Print the progress of the descriptor
            if mod(j,50) == 0
                disp(strcat(num2str(j)))
            end
            
            % Get the descriptors
            tic;
            [~, d] = descriptors(I, descr_type,descr_step_size);
            toc;
            D = vertcat(D,d');
        end
    end
end

