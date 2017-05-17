function [ height_map ] = construct_surface( p, q, W, H )
%CONSTRUCT_SURFACE construct the surface function represented as height_map
%   p : measured value of df / dx
%   q : measured value of df / dy
%   W : the width (counting the number of columns) of the height_map
%   H : the height (counting the number of rows) of the height_map
%   height_map: the reconstructed surface

height_map = zeros(W, H);

% TODO: Your code goes here
% top left corner of height_map is zero
% for each pixel in the left column of height_map
%   height_value = previous_height_value + corresponding_q_value


for x = 2:W 
    height_map(x,1) = height_map(x-1,1) + q(x,1); % each pixel in the left column of height_map
end
    


% TODO: Your code goes here
% for each row
%   for each element of the row except for leftmost
%       height_value = previous_height_value + corresponding_p_value

 for x = 1:H            %every row
     for y = 2:W        %each element except he leftmost
         height_map(x,y) = height_map(x,y-1) + p(x,y) ;
     end
 end



end

