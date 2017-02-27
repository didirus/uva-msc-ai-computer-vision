function [ outIm ] = lucas_kanade(region_size, image1, image2 )

    for i = 1:region_size:size(image1,1) - (size(image1,1)/region_size)
        for j = 1:region_size:size(image1,2) - (size(image1,2)/region_size)
            % get regions
            region1 = image1(i:i+region_size-1,j:j+region_size-1);
            region2 = image2(i:i+region_size-1,j:j+region_size-1);
            
            % get derivatives
            Ix = conv2(region1,[-1 1;-1 1],'same');
            Iy = conv2(region1,[-1 -1;1 1],'same');
            Ix = reshape(Ix,region_size^2,1);
            Iy = reshape(Iy,region_size^2,1);
            
            % get optical flow
            A = [Ix Iy];
            It = (region1-region2);
            b = -It;
            b = reshape(b,region_size^2,1);  
            v = inv(A'*A)*(A'* double(b));
        end
    end
    
    outIm =0;
end

