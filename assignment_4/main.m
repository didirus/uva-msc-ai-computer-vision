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
    
    im1 = imread('/boat1.pgm');
    im2 = imread('/boat2.pgm');
    
    [trans_params, inliers] = image_alignment(im1, im2, 1, 14);
    
    
end