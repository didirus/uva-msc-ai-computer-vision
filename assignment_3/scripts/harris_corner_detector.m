function H = harris_corner_detector(image)  
    sigma = 1;
    kernel_size = 3;
    
    % compute Ix
    gaussfilter_x = gauss(sigma, kernel_size);
    [smoothed_image_x, ~] = gaussDer(image, gaussfilter_x, sigma);
    
    
    % compute Iy
    gaussfilter_y = gauss(sigma, kernel_size);
    gaussfilter_y = gaussfilter_y';
    [smoothed_image_y, ~] = gaussDer(image, gaussfilter_y, sigma);
    
    % compute A
    A = smoothed_image_x .^ 2;
    kernel = fspecial('gaussian', [kernel_size kernel_size], sigma);
    A = convn(A, kernel, 'same');
    
    % compute B
    B = smoothed_image_x .* smoothed_image_y;
    kernel = fspecial('gaussian', [kernel_size kernel_size], sigma);
    B = convn(B, kernel, 'same');
    
    % compute C
    C = smoothed_image_y .^ 2;
    kernel = fspecial('gaussian', [kernel_size kernel_size], sigma);
    C = convn(C, kernel, 'same');
    
    % compute H
    H = (A.*C-B.^2) - 0.04*(A+C).^2;
    
    % get corner points
    threshold = 0.00001;
    
    rows = size(image, 1); %no. of rows in image
    cols = size(image, 2); %no. of cols in image
    
    imOut = zeros([rows, cols], 'uint8');
    
    %centering
    r_center = (kernel_size-1)/2; 
    c_center = (kernel_size-1)/2;
    
    for i = 1:3
        image1 = image(:,:,i);
        for r_index = r_center+1:(rows-r_center)
            for c_index = c_center+1:(cols-c_center)
                window = image1((r_index - r_center):(r_index + r_center), (c_index - c_center):(c_index + c_center));
%                 if (greater than neightbours) and (greater than threshold)
                    
            end
        end
        
    end
    
    
    %imshow(H)

    
    %figure;
    
    
end

