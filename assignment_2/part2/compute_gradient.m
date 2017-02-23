function [im_magnitude, im_direction] = compute_gradient(image)

    %convolution to get the gradient
    %sobel kernel
    grad_v = [1 +2 +1; 0 0 0; -1 -2 -1];
    grad_h = grad_v';
    
    G_x = conv2(grad_h, image);
    G_y = conv2(grad_v, image);
    
    %compute magnitude and direction of the gradients
    im_magnitude = sqrt(G_x.^2+G_y.^2);
    im_direction = tan(G_x./G_y).^(-1);
    
    %plots
    subplot(221);
    imshow(G_x)
    title('Gradient X')
    
    subplot(222);
    imshow(G_y)
    title('Gradient Y')
    
    subplot(223);
    imshow(uint8(im_magnitude))
    title('Magnitude')
    
    subplot(224);
    imshow(im_direction)
    title('Direction')
    
end

