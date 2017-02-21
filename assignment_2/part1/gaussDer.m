function [ imOut Gd ] = gaussDer ( image ,G , sigma )

%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

kernel_size = length(G);
Gd = zeros(size(G));

temp_value = kernel_size/2;
temp_value = int16(temp_value) - 1;
values = (-temp_value):1:(temp_value) ;
constant = -1/(sigma^2) ;

for i=1:length(G)
    Gd(i) = constant * values(i) * G(i);
end

%Do convolution
imOut = conv2(image,Gd);

end

