function [ albedo, normal, p, q ] = compute_surface_gradient( stack_images, scriptV )

%COMPUTE_SURFACE_GRADIENT compute the gradient of the surface
%   stack_image : the images of the desired surface stacked up on the 3rd
%   dimension
%   scriptV : matrix V (in the algorithm) of source and camera information
%   albedo : the surface albedo
%   normal : the surface normal
%   p : measured value of df / dx
%   q : measured value of df / dy

W = size(stack_images, 1);
H = size(stack_images, 2);

% create arrays for 
%   albedo, normal (3 components)
%   p measured value of df/dx, and
%   q measured value of df/dy
albedo = zeros(W, H, 1);
normal = zeros(W, H, 3);
p = zeros(W, H);
q = zeros(W, H);

% TODO: Your code goes here
% for each point in the image array
%   stack image values into a vector i
%   construct the diagonal matrix scriptI
%   solve scriptI * scriptV * g = scriptI * i to obtain g for this point
%   albedo at this point is |g|
%   normal at this point is g / |g|
%   p at this point is N1 / N3
%   q at this point is N2 / N3
% ivector = zeros(1,5)
% scripti = zeros(5,5)
% 
% for a = 1:5
%     
%     ivector(1,a) = stack_images(:,:,a)scrip
% %     scripti (a,a) = ivector(a)
    
% end

for x = 1:H
    for y = 1:W
        
        i = stack_images(x,y,:) ;               % creating the i vector
        i = squeeze(i) ;                        % correcting the dimentionality
        i = double(i) ;                         % making it double for further computation 
        
        scriptI = diag(i) ;                     % Diagonal matrix with i vector on diagonal
        
        scriptI = double(scriptI) ;             % making it double for further computation 
        scriptV = double(scriptV);              % making it double for further computation 
        
        I_V = scriptI * scriptV ;               % I_V = scriptI * scriptV
               
        I_i = scriptI * i ;                     % I_i = scriptI * i
        
        g = pinv(I_V) * I_i ;                   % take inverse and multiply 
        
        albedo(x,y,:) = norm(g) ;               % albedo = norm(g)
        
        normal(x,y,:) = g /(norm(g)) ;          % normal = g / |g|
        
        p(x,y) = normal(x,y,1)/normal(x,y,3) ;  % p = N1/N3
        q(x,y) = normal(x,y,2)/normal(x,y,3) ;  % p = N2/N3
    end
end

end

