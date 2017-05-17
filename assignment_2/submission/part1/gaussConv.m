function [ conv ] = gaussConv( image,sigma_x,sigma_y,kernel_size )
Gauss_x = gauss(sigma_x, kernel_size);
Gauss_y = gauss(sigma_y, kernel_size);
conv = conv2(Gauss_x, Gauss_y, image, 'full');
end
