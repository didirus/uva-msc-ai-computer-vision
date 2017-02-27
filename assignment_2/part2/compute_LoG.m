function imOut = compute_LoG(image, LOG_type)
    switch LOG_type
        case 1
            %method 1
            % Smoothing the image with a Gaussian operator,
            % then taking the Laplacian of the smoothed image.
            % smooth with gauss filter
            blurred = imgaussfilt(image, 0.7);
            % get laplacian filter
            h = fspecial('laplacian');
            %filter the smoothed image with laplacian
            imOut = imfilter(blurred, h);
            
        case 2
            %method 2
            %Convolving the image directly with LoG operator.
            
            % Directly get the LoG filter
            h = fspecial('log');
            %filter image with Log filter
            imOut = imfilter(image, h);
            
        case 3
            %method 3
            %Taking the diff between two Gaussians (DoG) computed
            %at different scales S1 and S2.
            sigma1 = 1;
            sigma2 = 4;
            % get difference of two smmothed image with two gauss filters(different sigma)
            imOut = imgaussfilt(image, sigma1,'FilterSize',3) - imgaussfilt(image, sigma2,'FilterSize',3);
    end
end
