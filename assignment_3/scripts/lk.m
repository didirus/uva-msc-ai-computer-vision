function [ outIm,C,u_p,v_p ] = lk(region_size, image1, image2 )
og_Image = image1;
image1 = rgb2gray(image1);
image2 = rgb2gray(image2);

% Calculate derivates
Ix = conv2(image1, 0.25 * [-1 1; -1 1]) + conv2(image2, 0.25 * [-1 1; -1 1]);
Iy = conv2(image1, 0.25 * [-1 -1; 1 1]) + conv2(image2, 0.25 * [-1 -1; 1 1]);
It = conv2(image1, 0.25 * ones(2)) + conv2(image2, -0.25 * ones(2));

region_center = floor(region_size / 2);
image_size = size(image1);
u = zeros(image_size);
v = zeros(image_size);
for i = region_center + 1:image_size(1) - region_center
  for j = region_center + 1:image_size(2) - region_center
    % Get values for current window
    Ix_window = Ix(i - region_center:i + region_center, j - region_center:j + region_center);
    Iy_window = Iy(i - region_center:i + region_center, j - region_center:j + region_center);
    It_window = It(i - region_center:i + region_center, j - region_center:j + region_center);

    Ix_window = Ix_window';
    Iy_window = Iy_window';
    It_window = It_window';

    A = [Ix_window(:) Iy_window(:)];
%     disp(size(A))
    U = pinv(A' * A) * A' * -It_window(:);

    u(i, j) = U(1);
    v(i, j) = U(2);
    
%     disp(i)
%     disp(j)
  end
end


%C from Harris inbuilt function. put the implemented one here

% inbuilt method
% C = corner(image1,'Harris');
% disp(size(image1))
% 
[~,r,c] = harris_corner_detector(image1);
% disp(size(r))
% C = zeros()
C = [c r];
% disp('hello')
% disp(size(C))
% disp(size(v))
% disp(size(u,1))
% disp(size(u(631,354)))



%temp for loop
u_p = zeros(size(C));
v_p = zeros(size(C));
for k = 1:size(C,1)
    for l =1:1  %  size(C,2)-1
        %disp(C(k,l))
        %disp(C(k,l+1))
        if C(k,l) <= size(u,1) && C(k,l+1) <= size(u,2)
%             disp('hello')
            u_p(k,l) = u(C(k,l),C(k,l+1));
            v_p(k,l) = v(C(k,l),C(k,l+1));
        end
    end
end
        
%     
% disp(size(u_p))
% disp(v_p(:,1))
outIm = 0;

% fig = figure;
% axis equal
% % quiver(impyramid(impyramid(medfilt2(flipud(u), [5 5]), 'reduce'), 'reduce'), -impyramid(impyramid(medfilt2(flipud(v), [5 5]), 'reduce'), 'reduce'));
% % quiver(u,v) % - impyramid(flipud(v),'reduce')) 
% imshow(og_Image)
% % 
% % % imshow(imread('../sphere2.ppm'))
% hold on;
% % 
% quiver(C(:,1), C(:,2), u_p(:,1),v_p(:,1), 1,'r')
% axis off
% saveas(fig,'fig.png')

% %only vectors
% fig = figure;
% axis equal
% % imshow(image1,[])
% % hold on;
% quiver(u,v,1,'r')
% axis off
% saveas(fig,'fig.png')




end

