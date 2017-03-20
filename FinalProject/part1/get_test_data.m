function [X, Y_a, Y_m, Y_f, Y_c] = get_test_data(imageset, vocab_size, descr_type, centers)
    % To classify a new image, you should calculate its visual 
    % words histogram as described in Section 2.4 and use the 
    % trained support vector machine classifier to assign it to 
    % the most probable object class.
    
    
    classes = {'airplanes_test','motorbikes_test','faces_test','cars_test'};
    images_per_class = 50;
    row_dims = images_per_class * length(classes);
    
    ind = 1;
    Y_a = zeros(row_dims,1);
    Y_m = zeros(row_dims,1);
    Y_f = zeros(row_dims,1);
    Y_c = zeros(row_dims,1);
    
    X = zeros(row_dims, vocab_size); % features frequencies
    
    for i=1:length(classes)
        filename = char(strcat(imageset, classes(i), '/' ));
        for j = 1:images_per_class 
            imagename = strcat(filename,'img',num2str(j,'%.3d'),'.jpg');
            I = imread(imagename);
            
            % Get the descriptors
            [~, d] = descriptors(I, descr_type);
            
            % Get feature frequencies for SVM
            freqs = quantize(centers, d, vocab_size);
            freqs = freqs';
            X(ind,:) = freqs;
            
             % Get labels for SVM
            if i == 1
                Y_a(ind,:) = 1;
            elseif i == 2
                Y_m(ind,:) = 1;
            elseif i == 3
                Y_f(ind,:) = 1;
            elseif i == 4
                Y_c(ind,:) = 1;
            end
            ind = ind + 1;
        end
    end
end

