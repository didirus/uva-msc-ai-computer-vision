function [output_image] = rgb2grays(input_image)
[R,G,B] =  getColorChannels(input_image);


% converts an RGB into grayscale by using 4 different methods
% output_image = (max(R,G,B) + min(R,G,B)) / 2 ;


% ligtness method
output_image_1 = (max(input_image, [] , 3) + min(input_image, [] , 3))/2 ;

% average method
 output_image_2 = (R+G+B) / 3 ;
 
 
% luminosity method
 output_image_3 = 0.21 * R + 0.72 * G + 0.07 * B ;


% built-in MATLAB function 
output_image_4 = rgb2gray(input_image);



output_image(:,:,1) = output_image_1 ;
output_image(:,:,2) = output_image_2 ;
output_image(:,:,3) = output_image_3 ;
output_image(:,:,4) = output_image_4 ;
% output_image(:,:,5) = b ;
 
end

