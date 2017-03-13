function [ imOut ] = panorama( I1,I2,parameter)

parameter = [parameter(1) parameter(3) 0;
    parameter(2) parameter(4) 0;
    parameter(5) parameter(6) 1];

affineT = affine2d(parameter);
% from piazza: we can use imwarp to speed up the transformation process
% instead of using the multiple for loops

t_image = imwarp(I2 , affineT);

corners = [1 1 1 ; 
    1 size(I2, 1) 1 ;
    size(I2, 2) 1 1;
    size(I2, 2) size(I2, 1) 1];
% transforming the corners
t_corners = corners * parameter;
% extract the end points
LC = min(t_corners(:, 1)); %x-direction
TC = min(t_corners(:, 2)); %y-direction
%only need left corner and top corner


%Calculating the shifts for linear translating the images

I1x = 0;
ITx=0;
I1y=0;
ITy=0;

%finding the shift.(linear translation)
if LC<1
    I1x =  abs(LC)+1;
end

if LC >1
    %do
    ITx = LC -1;
end
if TC<1
    %do
    I1y = abs(TC) + 1;
end
if TC>1
    %do
    ITy = TC -1;
end

size(I1)
size(t_image)

newI1 = imtranslate(I1,[I1x , I1y],'OutputView','full');  %check for 'full'
newtransformed = imtranslate(t_image,[ITx,ITy],'OutputView','full');

% zero padding for padarray 
%getting error if we dont do this
%padding because our image size are not same

padI1x = 0;
padI1y = 0;
padTx = 0;
padTy = 0;

%how much padding. we need?

if size(newtransformed,1) - size(newI1,1) > 0
    padI1x = size(newtransformed,1) - size(newI1,1);
else
    padTx = size(newI1,1) - size(newtransformed,1) ;
end
if size(newtransformed,2) - size(newI1,2) > 0
    padI1y = size(newtransformed,2) - size(newI1,2);
else
    padTy = size(newI1,2) - size(newtransformed,2) ;
end

padedI1 = padarray(newI1,[padI1x,padI1y],0,'post');
padedtransform = padarray(newtransformed,[padTx,padTy],0,'post');
%method 1
imOut =  (padedI1/2 + padedtransform/2);

%method 2
% imOut = max(padedI1,padedtransform);
end

