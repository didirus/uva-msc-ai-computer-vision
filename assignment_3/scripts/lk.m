function [u, v] = lk(region_size, image1, image2)

    % Convert to grayscale
    if size(image1,3) > 1
        image1 = rgb2gray(image1);
        image2 = rgb2gray(image2);
    end

    % Calculate derivates
    Ix = conv2(double(image1), 0.25 * [-1 1; -1 1]) + conv2(double(image2), 0.25 * [-1 1; -1 1]);
    Iy = conv2(double(image1), 0.25 * [-1 -1; 1 1]) + conv2(double(image2), 0.25 * [-1 -1; 1 1]);
    It = conv2(double(image1), 0.25 * ones(2)) + conv2(double(image2), -0.25 * ones(2));
    
    % Get the center of the region
    region_center = floor(region_size / 2);
    
    % Some definitions
    image_size = size(image1);
    u = zeros(image_size);
    v = zeros(image_size);
    
    for i = region_center + 1:image_size(1) - region_center     % every row
        for j = region_center + 1:image_size(2) - region_center % every column
            
            % 3.3.1: Get values for current window
            Ix_window = Ix(i - region_center:i + region_center, j - region_center:j + region_center);
            Iy_window = Iy(i - region_center:i + region_center, j - region_center:j + region_center);
            It_window = It(i - region_center:i + region_center, j - region_center:j + region_center);

            % Transpose the values 
            Ix_window = Ix_window';
            Iy_window = Iy_window';
            It_window = It_window';

            % 3.3.2: For each region compute A, A' and b; 
            % then estimate optical flow
            A = [Ix_window(:) Iy_window(:)];
            U = pinv(A' * A) * A' * -It_window(:);
            u(i, j) = U(1);
            v(i, j) = U(2);
            
        end
    end
end