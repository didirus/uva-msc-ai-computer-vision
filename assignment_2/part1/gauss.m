function G = gauss( sigma, kernel_size )
%   gauss = 1-D gaussian kernel of size = kernel size

G = zeros(1,kernel_size);
temp_value = kernel_size/2;
temp_value = int16(temp_value) - 1;
values = (-temp_value):1:(temp_value) ;
constant_o = 1/(sqrt(2*pi*sigma)) ;
constant_i = -1/(2*(sigma^2)) ;
 
for i=1:length(G)
    temp = ((values(i))^2); %*constant_i ;
    temp = double(temp);
    temp = temp * constant_i;
    G(i) = constant_o * exp(temp) ;
end
     
end

