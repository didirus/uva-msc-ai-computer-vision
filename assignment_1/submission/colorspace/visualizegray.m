function visualizegray(input_image)
figure(1)
subplot(4,1,1)
imshow(input_image(:,:,1)) 


subplot(4,1,2)
imshow(input_image(:,:,2))

subplot(4,1,3)
imshow(input_image(:,:,3))

subplot(4,1,4)
imshow(input_image(:,:,4))

% subplot(5,1,5)
% imshow(input_image)

end

