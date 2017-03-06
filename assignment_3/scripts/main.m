% I1 = imread('../person_toy/00000001.jpg');
I1 = imread('../pingpong/0002.jpeg');
I1 = rgb2gray(I1);
% % %  I1 = imread('../../3.jpg');
% % %  I1 = rgb2gray(I1);
[H,r,c] = harris_corner_detector(I1);
Cp = [c r];
C = corner(I1,'Harris');


% figure(1)
% imshow(I1)
% hold on;
% plot(C(:,1),C(:,2),'r.','MarkerSize',5)

% 
% % syn1 = imread('../synth1.pgm');
% % syn2 = imread('../synth2.pgm');
% % syn1 = double(syn1);
% % syn2 = double(syn2);
% % imout = lucas_kanade(15, syn1, syn2 );
% 
% sphere1 = imread('../sphere1.ppm');
% sphere2 = imread('../sphere2.ppm');
% 
% % sphere1 = double(sphere1);
% % sphere2 = double(sphere2);
% % imout = lucas_kanade(15, sphere1, sphere2 );
% % 
% % % %new defined function
% imout = lk(15, rgb2gray(sphere1), rgb2gray(sphere2) );
