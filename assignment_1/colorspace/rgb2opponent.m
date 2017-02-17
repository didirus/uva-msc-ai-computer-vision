function [output_image] = rgb2opponent(input_image)
% converts an RGB image into opponent color space

[R,G,B] =  getColorChannels(input_image);

O1 =  (R-G) / sqrt(2);
O2 = (R+G-(2*B)) /sqrt(3) ;
O3 = (R+G+B)  / sqrt(3) ;

[a,b] = size(R) ;

output_image = zeros(a,b,3);

output_image(:,:,1) = O1 ;
output_image(:,:,2) = O2 ;
output_image(:,:,3) = O3 ;


end

