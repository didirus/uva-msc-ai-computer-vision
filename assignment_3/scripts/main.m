% I1 = imread('../person_toy/00000001.jpg');
% I2 = imread('../pingpong/0000.jpeg');
% 
% H = harris_corner_detector(I1);

syn1 = imread('../synth1.pgm');
syn2 = imread('../synth2.pgm');
sphere1 = imread('../sphere1.ppm');
sphere2 = imread('../sphere2.ppm');

imout = lucas_kanade(15, syn1, syn2 );