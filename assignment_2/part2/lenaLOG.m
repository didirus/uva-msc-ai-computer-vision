
lena = imread('../Images/image1.jpeg');
subplot(131)
imshow(compute_LoG(lena, 1))
subplot(132)
imshow(compute_LoG(lena, 2))
subplot(133)
imshow(compute_LoG(lena, 3))