function [smooth_image, subtracted_image, imOut] = unsharp( image , sigma , kernel_size , k )

    %get smoothed image with gaussian filter
    smooth_image = gaussConv(image,sigma,sigma,kernel_size);
    %Define padding as the smoothed image is bigger than Original image
    padding = int16((kernel_size-1)/2);

    height = (size(image,1));
    width = (size(image,2));

    imOut = zeros(size(image));
    % Subtract the smoothed image from the original one 
    for i=1+padding:height-padding
        for j=1+padding:width-padding
            imOut(i-padding,j-padding) = image(i-padding,j-padding) - smooth_image(i,j) ;
        end

    end
    subtracted_image = imOut;

    %Multipy with factor k
    imOut = imOut .* k;
    image = double(image);
    % final image is factoredimage plus original image
    imOut = imOut + image;

end