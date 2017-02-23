% I  = imread('../Images/image2.jpeg');
% X = denoise(I,'median',[3 3]);
% 
% imshow(X)


% 
% input = imread('../Images/input.png');
% reference = imread('../Images/reference.png');
% match_im = myHistMatching( input, reference );

% I  = imread('../Images/image3.jpeg');
% [x,y] = compute_gradient(I);



I  = imread('../Images/image4.jpeg');
sigma = 50;
kernel_size = 5;
k=2;

[x] = unsharp ( I , sigma , kernel_size , k );
% imshow(x,[])
