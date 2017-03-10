function [transformed_im] = transform(image, m, t) % [transformed_im, shift]  add shift aswell?
% estimate transformed image size by looking at how coners are tranformed
shift = zeros(2,1);

%get height and width
[H, W] = size(image);

%get the 4 corner points
TL_corner = [1,1];
TR_corner = [size(image,1),1];
BL_corner = [1,size(image,2)];
BR_corner = [size(image,1),size(image,2)];

%transform the corners based on transform paramenters
TL_corner_transformed = m * TL_corner' + t;
TR_corner_transformed = m * TR_corner' + t;
BL_corner_transformed = m * BL_corner' + t;
BR_corner_transformed = m * BR_corner' + t;

% x coords and y coords
x_coords = [TL_corner_transformed(1),TR_corner_transformed(1),BL_corner_transformed(1),BR_corner_transformed(1)];
y_coords = [TL_corner_transformed(2),TR_corner_transformed(2),BL_corner_transformed(2),BR_corner_transformed(2)];
% to get height and width of transformed image
x_size = round(max(x_coords)) - round(min(x_coords));
y_size = round(max(y_coords)) - round(min(y_coords));

% disp(x_coords)
% disp(round(min(x_coords)))
% disp(round(max(x_coords)))
% disp('hello')
% disp(round(min(y_coords)))
% disp(round(max(y_coords)))
% transformed_im = 0;


shift = [round(min(x_coords-1));round(min(y_coords-1))];
transformed_im = zeros(x_size,y_size);

for i = 1:x_size
    for j = 1:y_size
        % right matrix division for transformation
        inv = round(m \ [i;j] + shift -t );
        if ((inv(1)>0) && (inv(1) <= H) && (inv(2) > 0) && (inv(2) <= W))
%             disp('hello')
            transformed_im(i,j) = image(inv(1),inv(2));
        else
            
            %do nothing or leave them black
        end
        
    end
    
end
% 
kernel_size = [51 51];

%now take 9 elements into consideration. 3*3
kernel_r = kernel_size(1); %row
kernel_c = kernel_size(2); %column
rows_I = size(transformed_im, 1); %no. of rows in image
cols_I = size(transformed_im, 2); %no. of cols in image

imOut = zeros([rows_I, cols_I], 'uint8');
centre = (kernel_size(1) +1)/2;
%centering
r_dist = (kernel_r-1)/2;
c_dist = (kernel_c-1)/2;
%slide the window over the image
% take mean or median accordingly

for r_index = r_dist+1:(rows_I-r_dist)
    for c_index = c_dist+1:(cols_I-c_dist)
        
        subM = transformed_im((r_index - r_dist):(r_index + r_dist), (c_index - c_dist):(c_index + c_dist));
        if (subM(centre,centre) == 0)
            temp = mean(subM(:));
            disp(temp)
            imOut(r_index, c_index) = temp ; %median filter
%             disp('hello')
        else
            %do nothing again
        end
    end
end
imshow(transformed_im,[])
size(imOut)
size(transformed_im)
% imshow(imOut,[])
newimage = double(imOut) + double(transformed_im);
% imshow(newimage,[])
end