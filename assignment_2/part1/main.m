I = imread('Images/image1.jpeg');

Convolved = gaussConv(I,1,1,5);
imshow(Convolved)