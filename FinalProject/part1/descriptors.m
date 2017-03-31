function [ f , d ] = descriptors(I, type, step_size)
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
            I_gray = rgb2gray(I);
        else
            I_gray = I;
        end
        I_gray = im2single(I_gray);
        
        % Smooth image
        Is = vl_imsmooth(I_gray, sqrt((binSize/magnif)^2 - .25));
        
        % Dense sampling
        [f, ~] = vl_dsift(Is, 'size', binSize, 'step', step_size) ;
        f(3,:) = binSize/magnif ;
        f(4,:) = 0 ;
        
        if size(I,3) == 1
            r = I(:,:);
            g = I(:,:);
            b = I(:,:);
        else
            r = I(:,:,1);
            g = I(:,:,2);
            b = I(:,:,3);
        end
        % Point sampling
        [~ , d1] = vl_sift(single(r), 'frames', f);
        [~ , d2] = vl_sift(single(g), 'frames', f);
        [~ , d3] = vl_sift(single(b), 'frames', f);
        d = [d1';d2';d3'];
        d = d';
        
        
        
    end
    
    % Point SIFT
    if strcmp(type,'keypoints')
        
        % Convert to grayscale
        if size(I,3) >1
            I = rgb2gray(I);
        end

        [f, ~] = vl_sift(I);
        if size(I,3) == 1
            r = I(:,:);
            g = I(:,:);
            b = I(:,:);
        else
            r = I(:,:,1);
            g = I(:,:,2);
            b = I(:,:,3);
        end
        % Point sampling
        [~ , d1] = vl_sift(single(r), 'frames', f);
        [~ , d2] = vl_sift(single(g), 'frames', f);
        [~ , d3] = vl_sift(single(b), 'frames', f);
        d = [d1';d2';d3'];
        d = d';
        
        
        
    end

    % RGB SIFT
    if strcmp(type,'RGBSIFT')
        [f,d] = vl_phow(I,'color','rgb','step', step_size);
    end
    
    % rgb SIFT
    if strcmp(type,'rgbSIFT')
        if size(I,3) > 1
            I_gray = rgb2gray(I);
        else
            I_gray = I;
        end
        I_gray = im2single(I_gray);
        
        % Smooth image
        Is = vl_imsmooth(I_gray, sqrt((binSize/magnif)^2 - .25));
        
        % Dense sampling
        [f, ~] = vl_dsift(Is, 'size', binSize, 'step', step_size) ;
        f(3,:) = binSize/magnif ;
        f(4,:) = 0 ;
        
        
        if size(I,3) == 1
            r = I(:,:);
            g = I(:,:);
            b = I(:,:);
        else
            r = I(:,:,1);
            g = I(:,:,2);
            b = I(:,:,3);
        end
        
        [a1,b1] = size(r);
        
        sumrgb = r + g + b;
        r = double(r) ./ double(sumrgb);
        g = double(g) ./ double(sumrgb);
        b = double(b) ./ double(sumrgb);
        
        oppImage = zeros(a1, b1, 3 );

        oppImage(:,:,1) = r ;
        oppImage(:,:,2) = g ;
        oppImage(:,:,3) = b ;
        
        oppImage = im2single(oppImage);
        
        [~ , d1] = vl_sift(oppImage(:,:,1),'frames', f);
        [~ , d2] = vl_sift(oppImage(:,:,2),'frames', f);
        [~ , d3] = vl_sift(oppImage(:,:,3),'frames', f);
        d = [d1';d2';d3'];
        d = d';
%         f = 0;
    end

    % Opponent SIFT
    if strcmp(type,'opponent')
        [f,d] = vl_phow(I,'color','opponent', 'step', step_size);
    end
    
    if strcmp(type,'grayDense')
         if size(I,3) > 1
            I_gray = rgb2gray(I);
        else
            I_gray = I;
        end
        I_gray = im2single(I_gray);
        
        % Smooth image
        Is = vl_imsmooth(I_gray, sqrt((binSize/magnif)^2 - .25));
        
        % Dense sampling
        [f, ~] = vl_dsift(Is, 'size', binSize, 'step', step_size) ;
        f(3,:) = binSize/magnif ;
        f(4,:) = 0 ;
        [~ , d] = vl_sift(single(I_gray), 'frames', f);
%         d = d';
        
    end
    
    if strcmp(type,'grayKeypoint')
         if size(I,3) > 1
            I_gray = rgb2gray(I);
        else
            I_gray = I;
        end
        I_gray = im2single(I_gray);
        
        % Smooth image
        [f , d] = vl_sift(single(I_gray));
%         d = d';
        
    end
    
    if strcmp(type,'opponentKeypoint')
    if size(I,3) > 1
            I_gray = rgb2gray(I);
        else
            I_gray = I;
        end
        I_gray = im2single(I_gray);
        
        
        if size(I,3) == 1
            r = I(:,:);
            g = I(:,:);
            b = I(:,:);
        else
            r = I(:,:,1);
            g = I(:,:,2);
            b = I(:,:,3);
        end
        
        [a1,b1] = size(r);
        r = double(r);
        g = double(g);
        b = double(b);
        
%         sumrgb = r + g + b;
%         r = double(r) ./ double(sumrgb);
%         g = double(g) ./ double(sumrgb);
%         b = double(b) ./ double(sumrgb);
%         
        O1 =  (r-g) / sqrt(2);
        O2 = (r+g-(2*b)) /sqrt(3) ;
        O3 = (r+g+b)  / sqrt(3);
        
        oppImage = zeros(a1, b1, 3 );

        oppImage(:,:,1) = O1 ;
        oppImage(:,:,2) = O2 ;
        oppImage(:,:,3) = O3 ;
        
        oppImage = im2single(oppImage);
        
        [~ , d1] = vl_sift(oppImage(:,:,1));
        [~ , d2] = vl_sift(oppImage(:,:,2));
        [~ , d3] = vl_sift(oppImage(:,:,3));
        d = [d1';d2';d3'];
        d = d';
        f = 0;
    end
    

    

end

