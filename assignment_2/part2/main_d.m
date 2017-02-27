
% test = 'denoise';
%  test = 'Histogram_matching';
% test = 'compute_gradient';
% test = 'unsharp';
test = 'LoG';



    %2.1
    if (strcmp(test,'denoise'))

        I  = imread('../Images/image2.jpeg');
        I = double(I);
        X = denoise(I,'median',[3 3]);

        imshow(X,[])
    end
    %2.2
    if (strcmp(test,'Histogram_matching'))
        input = imread('../Images/input.png');
        reference = imread('../Images/reference.png');
        input= double(input);
        reference = double(reference);
        match_im = myHistMatching( input, reference );
    end
    %2.3
    if (strcmp(test,'compute_gradient'))
        I  = imread('../Images/image3.jpeg');
        I = double(I);
        [x,y] = compute_gradient(I);
    end
    %2.4
    if (strcmp(test,'unsharp'))
        image  = imread('../Images/image4.jpeg');
        I=double(image);
        sigma = 2;
        [def_smooth, def_subtract, def_out]  = unsharp ( I , sigma , 3 , 1 );
        [k_smooth, k_subtract, k_out]  = unsharp ( I , sigma , 3 , 5 );
        [kernel_smooth, kernel_subtract, kernel_out] = unsharp ( I , sigma , 15 , 1 );

        figure
        subplot(3,4,1)
        imshow(image,[])
        title('original image')
        subplot(3,4,2)
        imshow(def_smooth,[])
        title(sprintf('smoothed image\n sigma = 2, kernel = 3x3'))
        subplot(3,4,3)
        imshow(def_subtract,[])
        title('subtracted image')
        subplot(3,4,4)
        imshow(def_out,[])
        title(sprintf('final image\nk = 1'))
        subplot(3,4,5)
        imshow(image,[])
        subplot(3,4,6)
        imshow(k_smooth,[])
        title('sigma = 2, kernel = 3x3')
        subplot(3,4,7)
        imshow(k_subtract,[])
        subplot(3,4,8)
        imshow(k_out,[])
        title('k = 5')
        subplot(3,4,9)
        imshow(image,[])
        subplot(3,4,10)
        imshow(kernel_smooth,[])
        title('sigma = 2, kernel = 15x15')
        subplot(3,4,11)
        imshow(kernel_subtract,[])
        subplot(3,4,12)
        imshow(kernel_out,[])
        title('k = 1')
    end

    %2.5

    if (strcmp(test,'LoG'))
    %     image = imread('../Images/lenna.jpg');
    %     image = rgb2gray(image);
        [X, map] = imread('../Images/image1.jpeg');
        if ~isempty(map)
            image = ind2gray(X,map);
        end
        image = double(image);

        subplot(221)
        imshow(image,[])
        title('Original Image')
        subplot(222)
        imshow(compute_LoG(image, 1),[])
        title(sprintf('Method 1, Kernel 3x3,\n Sigma 0.7'))
        subplot(223)
        imshow(compute_LoG(image, 2),[])
        title('Method 2, Kernel 3x3')
        subplot(224)
        imshow(compute_LoG(image, 3),[])
        title(sprintf('Method 3, Kernel 3x3,\n Sigma1 = 1, Sigma2=4 '))
    end
