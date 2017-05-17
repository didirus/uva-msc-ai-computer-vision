im2 = imread('../right.jpg');
im1 = imread('../left.jpg');
% % 
% % % imshow(I,[])
% % Ia = single(Ia) ;
% % Ib = single(Ib) ;
% % 
% % [fa, da] = vl_sift(Ia) ;
% % [fb, db] = vl_sift(Ib) ;
% % 
% % [matches, scores] = vl_ubcmatch(da, db) ;
% 
[trans_params, inliers] = image_alignment(im2, im1, 5000, 40);
m = reshape(trans_params(1:4),[2 2]);
m = m';
t = trans_params(5:6);
[t_image] = transform(im2, m, t);
t=trans_params;
% t = [t(1) t(3) 0; t(2) t(4) 0; t(5) t(6) 1];
% % 
% % 
% % stitch(im1,im2,t,'average'); 
% % 
% % imshow(t_image,[]);
im1 = rgb2gray(im1);
im2=rgb2gray(im2);
% [imout] = stitch(im1,im2,t,'average');


% [imout] = stitch2(im1,im2,t_image,m,t);
[imout] = panorama(im1,im2,t);
