function imOut = unsharp ( image , sigma , kernel_size , k )

smooth_image = gaussConv(image,sigma,sigma,kernel_size);
padding = int16((kernel_size-1)/2);

height = (size(image,1));
width = (size(image,2));

imOut = zeros(size(image));

for i=1+padding:height-padding
    for j=1+padding:width-padding
        imOut(i-padding,j-padding) = image(i-padding,j-padding) - smooth_image(i,j) ;
    end
    
end
subtracted_image = imOut;
imOut = imOut .* k;
image = double(image);
imOut = imOut + image;

figure
subplot(2,2,1)
imshow(image,[])
title('input image')

subplot(2,2,2)
imshow(smooth_image,[])
title('smoothed image')

subplot(2,2,3)
imshow(subtracted_image,[])
title('subtracted image')

subplot(2,2,4)
imshow(imOut,[])
title('final image')

end