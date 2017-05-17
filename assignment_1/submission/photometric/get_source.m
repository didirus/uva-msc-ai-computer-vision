function [ scriptV ] = get_source(scale_factor)

%   GET_SOURCE compute illumination source property 
%   scale_factor : arbitrary 


if nargin == 0
    scale_factor = 1;
end


% TODO: define arbitrary direction to V

% Light sources rontal, left-above, right-above, right-below, left-below

V = [0 0 -1 ; 1 1 -1; -1 1 -1; 1 -1 -1 ; -1 -1 -1] ;



scriptV = zeros(5,3); % Init ScriptV with zeros

% TODO: normalize V into scriptV

for x = 1:5
     normal = norm(V(x,:)) ;
     scriptV(x,:) = V(x,:) / normal ;
end


% scale up to scale factor before return
scriptV = scale_factor * scriptV;

end

