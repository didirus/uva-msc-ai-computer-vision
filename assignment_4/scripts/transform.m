function [newimage] = transform(image, m, t) % [transformed_im, shift]  add shift aswell?
    % estimate transformed image size by looking at how coners are tranformed
    shift = zeros(2,1);

    %get height and width
    [R, C] = size(image);

    %get the 4 corner points [c, r]
    TL_corner = [1,1];
    TR_corner = [size(image,2),1];
    BL_corner = [1, size(image,1)];
    BR_corner = [size(image,2),size(image,1)];

    %transform the corners based on transform paramenters
    TL_trans = m * TL_corner' + t;
    TR_trans = m * TR_corner' + t;
    BL_trans = m * BL_corner' + t;
    BR_trans = m * BR_corner' + t;

    c_pos = [TL_trans(1),TR_trans(1),BL_trans(1),BR_trans(1)];
    r_pos = [TL_trans(2),TR_trans(2),BL_trans(2),BR_trans(2)];

    % to get height and width of transformed image
    r_size = round(max(r_pos)) - round(min(r_pos));
    c_size = round(max(c_pos)) - round(min(c_pos));

    shift = [round(min(c_pos));round(min(r_pos))];
    transformed_im = zeros(r_size,c_size);
    
    disp('size new imag')
    disp(size(transformed_im))
    disp('size shift')
    disp(shift)
    for c = 1:C
        for r = 1:R
            new_pos1 = m * [c;r] + t;
            new_pos = new_pos1 - shift;
            if round(new_pos(1)) > 0 && round(new_pos(2)) > 0
                transformed_im(round(new_pos(2)), round(new_pos(1))) = image(r,c);
            end
        end
    end
    
    kernel_size = [5 5];

    %now take 9 elements into consideration. 3*3
    kernel_r = kernel_size(1); %row
    kernel_c = kernel_size(2); %column
    rows_I = size(transformed_im, 1); %no. of rows in image
    cols_I = size(transformed_im, 2); %no. of cols in image

    imOut = zeros(rows_I, cols_I);
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
                imOut(r_index, c_index) = temp ; %median filter
            end
        end
    end
    newimage = double(imOut) + double(transformed_im);
end