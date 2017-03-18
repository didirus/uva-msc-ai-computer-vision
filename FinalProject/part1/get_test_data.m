function [ X ] = get_test_data(vocab_size, descr_type, centers)
    % To classify a new image, you should calculate its visual 
    % words histogram as described in Section 2.4 and use the 
    % trained support vector machine classifier to assign it to 
    % the most probable object class.
    
    classes = {'airplanes_test','motorbikes_test','faces_test','cars_test'};
    ind = 1;
    X = zeros(200, vocab_size); % features frequencies
    
    for i=1:length(classes)
        filename = char(strcat('../Caltech4/ImageData/', classes(i), '/' ));
        for j =1:50
            imagename = strcat(filename,'img',num2str(j,'%.3d'),'.jpg');
            I = imread(imagename);
            
            % Get the descriptors
            [~, d] = descriptors(I, descr_type);
            
            % Get feature frequencies for SVM
            freqs = quantize(centers, d, vocab_size);
            freqs = freqs';
            X(ind,:) = freqs;
        end
    end
end

