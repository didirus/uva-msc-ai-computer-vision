%make video from sequence
outputVideo = VideoWriter(fullfile('vector.avi'));
outputVideo.FrameRate = 6;
open(outputVideo)

% imageNames = dir(fullfile('../pingpong','*.jpeg'));
% imageNames = {imageNames.name}';
%104 or 53
for ii = 1:103
    
%     filename = ['../person_toy/00000' num2str(ii,'%03d') '.jpg'];
%     filename = ['../pingpong/00' num2str(ii-1,'%02d') '.jpeg'];% 2d or 3d
%     disp(num2str(ii,'%03d'))
    filename = ['new2/' num2str(ii,'%d') '.png'];
    img = imread(filename);
    writeVideo(outputVideo,img)
end

close(outputVideo)
