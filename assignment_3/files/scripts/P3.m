test = 'tracking';

region_size = 15;
sigma = 3;
kernel_size = 13;
threshold = 200;
window_size = 19;


img1 = imread('../person_toy/00000001.jpg');
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


if (strcmp(test,'tracking'))
     test1 = 'person_toy';
%     test1 = 'pingpong';

    if strcmp(test1, 'person_toy')
        nr_images = 103;
        [~,r,c,~,~] = harris_corner_detector(imread('../person_toy/00000001.jpg'), sigma, kernel_size, threshold, window_size);
    elseif strcmp(test1, 'pingpong')
        nr_images = 53;
        [~,r,c,~,~] = harris_corner_detector(imread('../pingpong/0000.jpeg'), sigma, kernel_size, threshold, window_size);
    end

    % Getting the corners with Harris Corner detection
    
    
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
        [u, v] = lk(region_size, img1, img2, M);
          
        fig = figure(i);   
        axis equal
        imshow(rgb2gray(img1))
        hold on;
        q = quiver(M(:,2) , M(:,1), u' , v');
        q.Color = 'red';
        q.LineWidth = 1;
        hold on;
        plot(C(:,2),C(:,1),'r.','MarkerSize',15)
        n_f = ['new2/' num2str(i) '.png'];
        saveas(fig,n_f)
        pause(1);
        close(fig)
        

        % Getting the corners based on previous opical flow
%         C(:,1) = C(:,1) + 7.5 * u';
%         C(:,2) = C(:,2) + 7.5 * v';
        
    end
end