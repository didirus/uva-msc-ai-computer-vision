function [output_image] = rgb2normedrgb(input_image)
% converts an RGB image into normalized rgb

[R,G,B] =  getColorChannels(input_image);
sumRGB = R +G +B ;

r =  R ./ sumRGB;
g = G ./ sumRGB ;
b = B  ./ sumRGB ;

[a1,b1] = size(R) ;

output_image = zeros(a1,b1,3);

output_image(:,:,1) = r ;
output_image(:,:,2) = g ;
output_image(:,:,3) = b ;


end

