function imOut = denoise(image, kernel_type, kernel_size)
    kernel_r = kernel_size(1);
    kernel_c = kernel_size(2);
    rows_I = size(image, 1);
    cols_I = size(image, 2);
    imOut = zeros([rows_I, cols_I], 'uint8');
    
    r_dist = (kernel_r-1)/2;
    c_dist = (kernel_c-1)/2;
    
    for r_index = r_dist+1:(rows_I-r_dist)
        for c_index = c_dist+1:(cols_I-c_dist)
            subM = image((r_index - r_dist):(r_index + r_dist), (c_index - c_dist):(c_index + c_dist));
            if strcmp(kernel_type, 'box')
                imOut(r_index, c_index) = mean(subM(:)) ; %box filter
            end
            
            if strcmp(kernel_type , 'median')
                imOut(r_index, c_index) = median(subM(:)); %median filter
            end
        end
    end
    
    imshow(imOut,[])
end