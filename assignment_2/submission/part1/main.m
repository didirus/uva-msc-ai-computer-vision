I = imread('Images/image1.jpeg');

Convolved_1D = gauss(1,5);
 
Convolved_2D = gaussConv(I,1,1,5);
Convolved_2D = int8(Convolved_2D);
% imshow(Convolved_2D)

[Convolved_der Gd] = gaussDer(I,Convolved_1D,1);
Convolved_der = int8(Convolved_der);
imshow(Convolved_der, [])
