for ii = [8 25 58 85]%1:103
    filename = ['../person_toy/00000' num2str(ii,'%03d') '.jpg'];
    filename1 = ['../person_toy/00000' num2str(ii+1,'%03d') '.jpg'];
%     filename = ['../pingpong/00' num2str(ii-1,'%02d') '.jpeg'];
%     filename1 = ['../pingpong/00' num2str(ii,'%02d') '.jpeg'];
    img = imread(filename);
    img1 = imread(filename1);
    [imout,C,u,v] = lk(15, img,img1);
    
    fig = figure(ii);
%     figure('Visible','off')   

    axis equal
    % quiver(impyramid(impyramid(medfilt2(flipud(u), [5 5]), 'reduce'), 'reduce'), -impyramid(impyramid(medfilt2(flipud(v), [5 5]), 'reduce'), 'reduce'));
    % quiver(u,v) % - impyramid(flipud(v),'reduce')) 
    imshow(img)
    % 
    % % imshow(imread('../sphere2.ppm'))
    hold on;
    % 
    quiver(C(:,1), C(:,2), v(:,1),u(:,1), 1,'r') %try changing u,v
    axis off
    n_f = ['new2/' num2str(ii) '.png'];
    saveas(fig,n_f)
%     hold 0ff
    close(fig)
    clear all
%     clear 

    
end


% testing 
% filename = ['../pingpong/0000.jpeg'];
% filename1 = ['../pingpong/0001.jpeg'];
% img = imread(filename);
% img1 = imread(filename1);
% [imout,C,u,v] = lk(15, img,img1);
% imshow(img)
% hold on;
% quiver(C(:,1), C(:,2), u(:,1),v(:,1), 1,'r')
