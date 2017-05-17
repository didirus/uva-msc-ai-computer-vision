function imOut = myHistMatching ( input , reference )
    %get histogram counts
    
    [counts_I,~] = imhist(input) ;
    [counts_R,~] = imhist(reference) ;
     
    % cumulative distributions
     c_input = cumsum(counts_I);
     c_ref = cumsum(counts_R);
     %normalize
     c_input = c_input ./ c_input(end) ;
     c_ref = c_ref ./ c_ref(end);
     %mapping
     M = zeros(256,1,'uint8');
     for i = 1:256
        [~,x] = min(abs(c_input(i) - c_ref));
        M(i) = x-1;
     end
     %map input image to reference image
     imOut = M(double(input)+1); 

    %plots

    figure
    subplot(3,2,1)
    imshow(input,[])
    title('input image')
    subplot(3,2,2)
    histogram(input)
    title('input histogram')
    subplot(3,2,3)
    imshow(reference,[])
    title('reference image')
    subplot(3,2,4)
    histogram(reference)
    title('reference histogram')
    subplot(3,2,5)
    imshow(imOut,[])
    title('Histogram Matched image')
    subplot(3,2,6)
    histogram(imOut)
    title('Histogram Matched histogram')

end