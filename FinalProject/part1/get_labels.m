function [ Y ] = get_labels(class, set, nr_images)
    
    if strcmp(set, 'train')
        start_im_ind = 151;
    elseif strcmp(set, 'test') 
        start_im_ind = 1;
    end
    
    classes = {'airplanes','motorbikes','faces','cars'};
    row_dims = nr_images * length(classes);
    
    Y = zeros(row_dims, 1);
    
    % Repeat for each class
    ind = 1;
    for i=1:length(classes)
        for j = start_im_ind : start_im_ind+nr_images-1 
            
            % Get labels for SVM
            if strcmp(class,classes(i))
                Y(ind,:) = 1;
            end
            
            ind = ind + 1;
            
        end
    end
end

