function [ f , d ] = descriptors(I, sampler, descr_type, step_size)
    % Samplers = 'dense', 'keypoints', 
    % SIFT descriptors = 'RGBSIFT', 'rgbSIFT', 'opponent', 'gray'
    
    % Convert to grayscale
    if size(I,3) > 1
        I_gray = rgb2gray(I);
    else
        I_gray = I;
    end
    
    % Convert to single precision
    I_gray = im2single(I_gray);
    I = im2single(I);
    
    % Settings for dense sampler
    binSize = 8 ;
    magnif = 3 ;
    
    if strcmp(descr_type,'RGB')
        if strcmp(sampler, 'dense')
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
            
        elseif strcmp(sampler, 'keypoints')
            [f, ~] = vl_sift(I_gray); 
            
            if size(I_gray,3) == 1
                r = I_gray(:,:);
                g = I_gray(:,:);
                b = I_gray(:,:);
            else
                r = I_gray(:,:,1);
                g = I_gray(:,:,2);
                b = I_gray(:,:,3);
            end
        end
   
        % Point sampling
        [~ , d1] = vl_sift(single(r), 'frames', f);
        [~ , d2] = vl_sift(single(g), 'frames', f);
        [~ , d3] = vl_sift(single(b), 'frames', f);
        d = [d1';d2';d3'];
        d = d';
    end

    % rgb SIFT
    if strcmp(descr_type,'rgbSIFT')
        if strcmp(sampler, 'dense')
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
            
        elseif strcmp(sampler, 'keypoints')
        
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

    % Opponent SIFT
    if strcmp(descr_type,'opponent')
        if strcmp(sampler, 'dense')
            [f,d] = vl_phow(I,'color','opponent', 'step', step_size);
        end
    end
    
    % Gray SIFT
    if strcmp(descr_type,'gray')
        if strcmp(sapmler, 'dense')  
            % Smooth image
            Is = vl_imsmooth(I_gray, sqrt((binSize/magnif)^2 - .25));

            % Dense sampling
            [f, ~] = vl_dsift(Is, 'size', binSize, 'step', step_size) ;
            f(3,:) = binSize/magnif ;
            f(4,:) = 0 ;
            [~ , d] = vl_sift(single(I_gray), 'frames', f);
            
        elseif strcmp(sampler, 'keypoints')
            [f , d] = vl_sift(single(I_gray));  
        end
    end
    
end

