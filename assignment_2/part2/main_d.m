% I  = imread('../Images/image2.jpeg');
% X = denoise(I,'median',[3 3]);
% 
% imshow(X)


% 
% input = imread('../Images/input.png');
% reference = imread('../Images/reference.png');
% match_im = myHistMatching( input, reference );

I  = imread('../Images/image3.jpeg');
[x,y] = compute_gradient(I);

