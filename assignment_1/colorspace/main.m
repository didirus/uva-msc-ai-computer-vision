% test your code by using this simple script

clear
clc
close all

I = imread('abc.jpg');

% J = ConvertColorSpace(I,'opponent');
 
%  close all
%    J = ConvertColorSpace(I,'rgb');
% 
%  close all
%   J = ConvertColorSpace(I,'hsv');
% 
%  close all
%  J = ConvertColorSpace(I,'ycbcr');
% 
%  close all
J = ConvertColorSpace(I,'gray');