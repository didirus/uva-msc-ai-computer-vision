function [new_image] = ConvertColorSpace(input_image, colorspace)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Converts an RGB image into a specified color space, visualize the 
% color channels and returns the image in its new color space.                     
%                                                        
% Colorspace options:                                    
%   opponent                                            
%   rgb -> for normalized RGB
%   hsv
%   ycbcr
%   gray
%
% P.S: Do not forget the visualization part!
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% convert image into double precision for conversions
input_image = im2double(input_image);
% disp(input_image)

if strcmp(colorspace, 'opponent')
    new_image = rgb2opponent(input_image); % fill in this function
%     disp(size(new_image))
elseif strcmp(colorspace, 'rgb')  
    new_image = rgb2normedrgb(input_image); % fill in this function
elseif strcmp(colorspace, 'hsv')
    new_image = rgb2hsv(input_image);
    % use the built-in function
elseif strcmp(colorspace, 'ycbcr')
    new_image = rgb2ycbcr(input_image);
    % use the built-in function
elseif strcmp(colorspace, 'gray')
    new_image = rgb2grays(input_image); % fill in this function
else
% if user inputs an unknow colorspace just notify and do not plot anything
    fprintf('Error: Unknown colorspace type [%s]...\n',colorspace);
    new_image = input_image;
    return;
end

if strcmp(colorspace,'gray')
    visualizegray(new_image);
else
    visualize(new_image); % fill in this function

end