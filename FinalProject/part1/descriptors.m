function [ f , d ] = descriptors( I, type)
binSize = 8 ;
magnif = 3 ;
I = im2single(I);
if strcmp(type,'dense')
    if size(I,3) >1
        I = rgb2gray(I);
    end
    I = im2single(I);
    Is = vl_imsmooth(I, sqrt((binSize/magnif)^2 - .25)) ;
    [f, d] = vl_dsift(Is, 'size', binSize) ;
    f(3,:) = binSize/magnif ;
    f(4,:) = 0 ;
    [f_, d_] = vl_sift(I, 'frames', f);
    f = f_;
    d= d_;
    
    
    
end

if strcmp(type,'normal')
    if size(I,3) >1
        I = rgb2gray(I);
    end
    
    [f, d] = vl_sift(I);
end


if strcmp(type,'rgbSIFT')
    [f,d] = vl_phow(I,'color','rgb');
end


if strcmp(type,'opponent')
    [f,d] = vl_phow(I,'color','opponent');
end


if strcmp(type,'RGBSIFT')
    
end

end

