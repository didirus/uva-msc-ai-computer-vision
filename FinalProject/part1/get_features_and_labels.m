function [ X,Y ] = get_features_and_labels(class, vocab_size, centers, descr_type)
    
    % Define the 4 classes
    classes = {'airplanes_train','motorbikes_train','faces_train','cars_train'};
    
    % For every image, get the descriptors, do quantization
    D = [];
    Y = zeros(20,1); % labels
    X = zeros(20, vocab_size); % features frequencies
    % Repeat for each class
    ind = 1;
    for i=1:length(classes)
        filename = char(strcat('../Caltech4/subdata/', classes(i), '/' ));
        for j =6:10
            imagename = strcat(filename,'img',num2str(j,'%.3d'),'.jpg');
            I = imread(imagename);
            
            % Get the descriptors
            [~, d] = descriptors(I, descr_type);
            
            % Get feature frequencies for SVM
            freqs = quantize(centers, d, vocab_size);
            freqs = freqs';
            X(ind,:) = freqs;
            
            % Get labels for SVM
            if strcmp(class,classes(i))
                Y(ind) = 1;
            else
                Y(ind) = -1;
            end
            ind = ind + 1;
            
        end
    end
end

