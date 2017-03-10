function [parameters, set_of_inliers] = image_alignment( image1, image2, N, P )
    
    % Converting images to grasca
    if size(image1,3) > 1
        image1 = rgb2gray(image1);
        image2 = rgb2gray(image2);
    end
    
    % Making the images singles 
    im1 = single(image1);
    im2 = single(image2);
    
    % Compute the keypoints and descriptors
    [fa, da] = vl_sift(im1);
    [fb, db] = vl_sift(im2);
    
    % Getting the matching keypoints
    [matches] = vl_ubcmatch(da, db);

    % Keeping track of the max_inliers for N iterations
    max_inliers = 0;
    
    % Get best set of transformation parameters in N iterations
    for i = 1:N
        
        % Pick P random matches
        random_indices = randi([1 size(matches,2)],1,P);
        picked_matches = zeros(2, P);
        for j = 1:P
            picked_matches(:,j) = matches(:,random_indices(j));
        end
        
        % Define the old and new x and y coordinates
        x = fa(1,picked_matches(1,:));
        y = fa(2, picked_matches(1,:));
        x_transf = fb(1, picked_matches(2,:));
        y_transf = fb(2, picked_matches (2,:));
        
        % Compute A and b 
        A = zeros(2*P, 6);
        b = zeros(2*P, 1);
        j = 1;
        for h = 1:2:2*P
            A(h,:) = [ x(j) y(j) 0 0 1 0 ];
            A(h+1,:) = [ 0 0 x(j) y(j) 0 1 ];
            b(h,:) = x_transf(j);
            b(h+1,:) = y_transf(j);
            j =  j + 1;
        end
        
        % Compute the parameters t and m
        t = pinv(A)*b;
        M = [t(1) t(2); t(3) t(4)];
        T = [t(5); t(6)];
        
        
        % Computing the transformed coordinates
        x_new = zeros(size(x));
        y_new = zeros(size(y));
        for j = 1:size(x,2)
            temp = (M * [x(j);y(j)] + T);
            x_new(j) = temp(1,:);
            y_new(j) = temp(2,:);
        end
        
        
        Euclid = sqrt(((x_transf - x_new).^ 2)+((y_transf - y_new).^ 2));
        
        if sum(Euclid<10) > max_inliers
            max_inliers = sum(Euclid<10);
            I = find(Euclid < 10);
            parameters = t;
            
            % Getting the coordinates of the inliers
            set_of_inliers = zeros(size(I,2),2);
            x_2 = x';
            y_2 = y';
            set_of_inliers(:,1) = x_2(I);
            set_of_inliers(:,2) = y_2(I);
        end
    end
            
        
        % Without arrows:
%         figure;
%         subplot (1,2,1);
%         imshow (uint8(im1));
%         hold on;
%         plot (x, y, 'b*');
%         subplot (1,2,2);
%         imshow (uint8(im2));
%         hold on;
%         plot (x_new', y_new', 'r*');
        
        % With arrows: 
%         figure(2) ; clf ;
%         imagesc(cat(2, im1, im2)) ;
% 
%         xa = fa(1,picked_matches(1,:)) ;
%         xb = x_new + size(im1,2) ;
%         ya = fa(2,picked_matches(1,:)) ;
%         yb = y_new ;
% 
%         hold on ;
%         h = line([xa ; xb], [ya ; yb]) ;
%         set(h,'linewidth', 1, 'color', 'b') ;
% 
%         vl_plotframe(fa(:,picked_matches(1,:))) ;
%         fb(1,:) = fb(1,:) + size(im1,2) ;
%         vl_plotframe(fb(:,picked_matches(2,:))) ;
%         axis image off ;

end

