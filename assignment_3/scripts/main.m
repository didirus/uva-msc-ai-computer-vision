% Uncomment for running particular part

%test = 'harris';
% test = 'lucas';
test = 'tracking';

region_size = 15;
sigma = 3;
kernel_size = 13;
threshold = 200;
window_size = 19;

% 3.1
if (strcmp(test,'harris'))
    I1a = imread('../person_toy/00000001.jpg');
    I2a = imread('../pingpong/0000.jpeg');
    I1b = rgb2gray(I1a);
    I2b = rgb2gray(I2a);
    
    [H,r,c] = harris_corner_detector(I2b, sigma, kernel_size, threshold, window_size);
    
    % plots
    figure;
%     subplot(1,3,1)
%     imshow(smoothed_image_x)
%     subplot(1,3,2)
%     imshow(smoothed_image_y)
%     subplot(1,3,3)
    imshow(I2b)
    hold on;
    plot(c,r,'r.','MarkerSize',15)

end

% 3.2 - 3.3
if (strcmp(test,'lucas'))
%     test1 = 'syn';
    test1 = 'sphere';
    if (strcmp(test1,'syn'))
        img1 = imread('../synth1.pgm');
        img2 = imread('../synth2.pgm');
    elseif (strcmp(test1,'sphere'))
        img1 = imread('../sphere1.ppm');
        img2 = imread('../sphere2.ppm');
    end
    
    M = zeros(floor(size(img1,1)/region_size)*floor(size(img1,2)/region_size),2);
    
    M_point_r = floor(region_size/2) +1 : region_size : size(img1,1);
    M_point_c = floor(region_size/2) +1 : region_size : size(img1,2);
    
    i = 1;
    for j = M_point_r
        for k = M_point_c
            M(i,1) = j;
            M(i,2) = k;
            i = i + 1;
        end
    end    
    
            
    [u, v] = lk(region_size, img1, img2, M);

    figure;
    axis equal
    imshow(img1);
    hold on
    %[m,n] = size(rgb2gray(syn1));
    %[x,y] = meshgrid(1:n, 1:m);
    quiver(M(:,2),M(:,1),u',v');

end

% 3.4
if (strcmp(test,'tracking'))
     test1 = 'person_toy';
 %   test1 = 'pingpong';

    if strcmp(test1, 'person_toy')
        nr_images = 103;
        [~,r,c] = harris_corner_detector(imread('../person_toy/00000001.jpg'), sigma, kernel_size, threshold, window_size);
    elseif strcmp(test1, 'pingpong')
        nr_images = 53;
        [~,r,c] = harris_corner_detector(imread('../pingpong/0000.jpeg'), sigma, kernel_size, threshold, window_size);
    end

    % Getting the corners with Harris Corner detection
    C = [r c];
    int_C = [r c];
    
    % for every image in the folder
    for i = 1:nr_images
        int_C = int16(C);
        if strcmp(test1, 'person_toy')
            img1 = imread(['../person_toy/00000' num2str(i,'%03d') '.jpg']);
            img2 = imread(['../person_toy/00000' num2str(i+1,'%03d') '.jpg']);
        elseif strcmp(test1, 'pingpong')
            img1 = imread(['../pingpong/00' num2str(i-1,'%02d') '.jpeg']);
            img2 = imread(['../pingpong/00' num2str(i,'%02d') '.jpeg']);
        end
        
        % Getting the optical flow arrows with Lucas-Kanade
        [u, v] = lk(region_size, img1, img2, int16(C));
        
        % Filter the arrows for only the corner points
%         u_corners = zeros(size(C,1),1); 
%         v_corners = zeros(size(C,1),1);
%         for k = 1:size(C,1)
%             if C(k,1) <= size(u,1) && C(k,2) <= size(u,2)
%                 u_corners(k) = u(C(k,1),C(k,2));
%                 v_corners(k) = v(C(k,1),C(k,2));
%             end
%         end
%         new_u = zeros(size(u));
%         new_v = zeros(size(v));
%         for k = 1:size(C,1)
%             if C(k,1) <= size(u,1) && C(k,2) <= size(u,2)
%                 new_u(C(k,1), C(k,2)) = u(C(k,1), C(k,2));
%                 new_v(C(k,1), C(k,2)) = v(C(k,1), C(k,2));
%             end
%         end
%         
        fig = figure(i);   
        axis equal
        imshow(rgb2gray(img1))
        hold on;
%         [m,n] = size(rgb2gray(img1));
%         [x,y] = meshgrid(1:n, 1:m);
        %disp(size(x))
        %disp(size(new_u))
        q = quiver(int_C(:,2),int_C(:,1),u',v');
        q.Color = 'red';
        q.LineWidth = 1;
        hold on;
        plot(C(:,2),C(:,1),'r.','MarkerSize',15)
        n_f = ['new3/' num2str(i) '.png'];
        saveas(fig,n_f)
        pause(.5);
        close(fig)
        

        % Getting the corners based on previous opical flow
        C(:,1) = C(:,1) + 7.5 * u';
        C(:,2) = C(:,2) + 7.5 * v';
        
    end
end

    
    
    
