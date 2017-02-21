function [ imOut ] = gaussConv( image , sigma_x , sigma_y , kernel_size )

Gauss_H = gauss(sigma_x,kernel_size);
Gauss_V = gauss(sigma_y,kernel_size);
Gauss_V = Gauss_V' ;
Gauss_H = Gauss_H / (sum(Gauss_H));
Gauss_V = Gauss_V / (sum(Gauss_V));

imOut = conv2(Gauss_H,Gauss_V,image);



end

