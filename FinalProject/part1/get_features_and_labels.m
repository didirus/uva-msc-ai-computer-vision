function [ X, Y ] = get_features_and_labels(imageset, class, vocab_size, centers, descr_type)
    
    % Define the 4 classes
    classes = {'airplanes_train','motorbikes_train','faces_train','cars_train'};
    images_per_class = 100;
    row_dims = images_per_class * length(classes);
    
    % For every image, get the descriptors, do quantization
    D = [];
    Y = zeros(row_dims, 1); % labels
    X = zeros(row_dims, vocab_size); % features frequencies
    
    % Repeat for each class
    ind = 1;
    for i=1:length(classes)
        filename = char(strcat(imageset, classes(i), '/' ));
        for j = 251 : 251+images_per_class-1  % should be based on "feature_extraction" setup
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
            
            % Get labels for SVM
            if strcmp(class,classes(i))
                Y(ind,:) = 1;
            end
            ind = ind + 1;
            
        end
    end
end

