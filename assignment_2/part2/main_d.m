% I  = imread('../Images/image2.jpeg');
% X = denoise(I,'median',[3 3]);
% 
% imshow(X)



input = imread('../Images/input.png');
reference = imread('../Images/reference.png');
match_im = myHistMatching( input, reference );

figure
subplot(3,2,1)
imshow(input)
subplot(3,2,2)
histogram(input)
subplot(3,2,3)
imshow(reference)
subplot(3,2,4)
histogram(reference)
subplot(3,2,5)
imshow(match_im)
subplot(3,2,6)
histogram(match_im)
