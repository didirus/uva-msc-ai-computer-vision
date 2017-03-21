function [ Y ] = get_labels(class, set)
    
    if strcmp(set, 'train')
        start_im_ind = 251;
        images_per_class = 100;
    elseif strcmp(set, 'test') 
        start_im_ind = 1;
        images_per_class = 50;
    end
    
    classes = {'airplanes','motorbikes','faces','cars'};
    row_dims = images_per_class * length(classes);
    
    Y = zeros(row_dims, 1);
    
    % Repeat for each class
    ind = 1;
    for i=1:length(classes)
        for j = start_im_ind : start_im_ind+images_per_class-1 
            
            % Get labels for SVM
            if strcmp(class,classes(i))
                Y(ind,:) = 1;
            end
            
            ind = ind + 1;
            
        end
    end
end

