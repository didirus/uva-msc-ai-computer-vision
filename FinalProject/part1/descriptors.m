function [ f , d ] = descriptors(I, type)
    % Type = 'dense', 'keypoints', 'RGBsift', 'rgbsift', 'Oppsift' 
    
    % Dense SIFT
    binSize = 8 ;
    magnif = 3 ;
    I = im2single(I);
    
    if strcmp(type,'dense')
        % Function vl_dsift and vl_sift to get 
        % dense and keypoins descriptors
        
        % Convert to grayscale and to single precision
        if size(I,3) > 1
            I = rgb2gray(I);
        end
        I = im2single(I);
        
        % Smooth image
        Is = vl_imsmooth(I, sqrt((binSize/magnif)^2 - .25));
        
        % Dense sampling
        [f, ~] = vl_dsift(Is, 'size', binSize) ;
        f(3,:) = binSize/magnif ;
        f(4,:) = 0 ;
        
        % Point sampling
        [f_, d_] = vl_sift(I, 'frames', f);
        f = f_;
        d = d_;
    end
    
    % Point SIFT
    if strcmp(type,'keypoints')
        
        % Convert to grayscale
        if size(I,3) >1
            I = rgb2gray(I);
        end

        [f, d] = vl_sift(I);
    end

    % RGB SIFT
    if strcmp(type,'RGBSIFT')
        [f,d] = vl_phow(I,'color','rgb');
    end
    
    % rgb SIFT
    if strcmp(type,'rgbSIFT')

        r = I(:,:,1);
        g = I(:,:,2);
        b = I(:,:,3);
        [a1,b1] = size(r)
        sumrgb = r + g + b;
        r = double(r) ./ double(sumrgb);
        g = double(g) ./ double(sumrgb);
        b = double(b) ./ double(sumrgb);
        
        normImage = zeros(a1, b1, 3 );

        normImage(:,:,1) = r ;
        normImage(:,:,2) = g ;
        normImage(:,:,3) = b ;
        [f , d] = descriptors(single(normImage),'RGBSIFT');



    end

    % Opponent SIFT
    if strcmp(type,'opponent')
        [f,d] = vl_phow(I,'color','opponent');
    end

    

end

