	% Tushar Nimbhorkar & Diede Rusticus
% Computer Vision '17
% Artificial Intelligence Master
% University of Amsterdam

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%% Select assignment and image by uncommenting the line %%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

test = 'image_alignment';
% test = 'image_stitching';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%% 3.1 Image Alignment %%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if (strcmp(test,'image_alignment'))
    
    im1 = imread('../boat1.pgm');
    im2 = imread('../boat2.pgm');
    
    [trans_params, inliers] = image_alignment(im1, im2, 5000, 150);
%     figure(2)
%     subplot(121)
%     
%     imshow(im2,[])
%     subplot(122)
%     
% %     [m, t] = ransac(100, 20, T);
%     % TODO m has to be transposed in a
%     m = reshape(trans_params(1:4),[2 2]);
%     t = trans_params(5:6);
%     a = [m;t'];
%     result = [a';0,0,1]';
%     trans = maketform('affine',result);
%     newImage = imtransform(im1,trans);
%     imshow(newImage,[]);
% %     imshowpair(im2,newIa);
%     title('Built in matlab');
    
% % new function to be implemented    
%     figure(3)
    [t_image] = transform(im1, m, t);
%     imshow(t_image,[]);
%     title('custom image transform');
end
