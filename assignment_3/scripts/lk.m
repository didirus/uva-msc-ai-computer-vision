function [u, v] = lk(region_size, image1, image2, P)

    % Convert to grayscale
    if size(image1,3) > 1
        image1 = rgb2gray(image1);
        image2 = rgb2gray(image2);
    end

    % Calculate derivates
    Ix = conv2(double(image1), 0.25 * [-1 1; -1 1]) + conv2(double(image2), 0.25 * [-1 1; -1 1]);
    Iy = conv2(double(image1), 0.25 * [-1 -1; 1 1]) + conv2(double(image2), 0.25 * [-1 -1; 1 1]);
    It = conv2(double(image1), 0.25 * ones(2)) + conv2(double(image2), -0.25 * ones(2));

    u = [];
    v = [];
    
    region_half = floor(region_size/2);
    
    % For every coordinate in P
    for i = 1:size(P,1)
        if ( P(i,1) - region_half) < 1 || (P(i,1) + region_half) > size(Ix,1) || (P(i,2) - region_half) < 1 || (P(i,2) + region_half) > size(Ix,2)
            region_half = region_half - 2;
        else
            region_half = floor(region_size/2);
        end
        start_r = P(i,1) - region_half;
        end_r = P(i,1) + region_half;
        
        start_c = P(i,2) - region_half;
        end_c = P(i,2) + region_half;
        
        % Define window
        Ix_window = Ix(start_r:end_r,start_c:end_c);
        Iy_window = Iy(start_r:end_r,start_c:end_c);
        It_window = It(start_r:end_r,start_c:end_c);
        
        % Transpose the values 
        Ix_window = Ix_window';
        Iy_window = Iy_window';
        It_window = It_window';

        % For each region compute A, A' and b; 
        % then estimate optical flow
        A = [Ix_window(:) Iy_window(:)];
        U = pinv(A) * -It_window(:);

        u = [u U(1)];
        v = [v U(2)];
        
    end
end