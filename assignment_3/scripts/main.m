% Uncomment for running particular part

% test = 'harris';
% test = 'lucas';
test = 'tracking';

region_size = 15;

% 3.1
if (strcmp(test,'harris'))
    I1 = imread('../person_toy/00000001.jpg');
    I2 = imread('../pingpong/0002.jpeg');
    I1 = rgb2gray(I1);
    I2 = rgb2gray(I2);
    [H,r,c] = harris_corner_detector(I1);
    Cp = [c r];
    C = corner(I1,'Harris');
end

% 3.2 - 3.3
if (strcmp(test,'lucas'))

    syn1 = imread('../synth1.pgm');
    syn2 = imread('../synth2.pgm');
    sphere1 = imread('../sphere1.ppm');
    sphere2 = imread('../sphere2.ppm');

    [u, v] = lk(region_size, syn1, syn2);
    figure;
    axis equal
    imshow(syn1);
    hold on

    quiver(u,v);

end

% 3.4
if (strcmp(test,'tracking'))
%     test1 = 'person_toy';
    test1 = 'pingpong';

    if strcmp(test1, 'person_toy')
        nr_images = 103;
        [~,r,c] = harris_corner_detector(imread('../person_toy/00000001.jpg'));
    elseif strcmp(test1, 'pingpong')
        nr_images = 53;
        [~,r,c] = harris_corner_detector(imread('../pingpong/0000.jpeg'));
    end

    % Getting the corners with Harris Corner detection
    C = [c r];
    disp('Corners dimension first image')
    disp(size(C))

    % for every image in the folder
    for i = 1:nr_images

        if strcmp(test1, 'person_toy')
            img1 = imread(['../person_toy/00000' num2str(i,'%03d') '.jpg']);
            img2 = imread(['../person_toy/00000' num2str(i+1,'%03d') '.jpg']);
        elseif strcmp(test1, 'pingpong')
            img1 = imread(['../pingpong/00' num2str(i-1,'%02d') '.jpeg']);
            img2 = imread(['../pingpong/00' num2str(i,'%02d') '.jpeg']);
        end
        
        % Getting the optical flow arrows with Lucas-Kanade
        [u, v] = lk(region_size, img1, img2); %size(u) = size(image)

        % Filter the arrows for only the corner points
        u_corners = zeros(size(C)); 
        v_corners = zeros(size(C));
        for k = 1:size(C,1)
            if C(k,1) <= size(u,1) && C(k,2) <= size(u,2)
                u_corners(k,1) = u(C(k,1),C(k,2));
                v_corners(k,1) = v(C(k,1),C(k,2));
            end
        end
        
        disp('U V corners dimensions: ')
        disp(size(u_corners), size(v_corners))
        
        fig = figure(i);   
        axis equal
        imshow(img1)
        hold on;
        quiver(C(:,1), C(:,2), u_corners(:,1),v_corners(:,1), 1,'r')
        axis off
        n_f = ['new3/' num2str(i) '.png'];
        saveas(fig,n_f)
        close(fig)

        % Getting the corners based on previous opical flow
        C = C + [u_corners v_corners];
    end
end

    
    
    
