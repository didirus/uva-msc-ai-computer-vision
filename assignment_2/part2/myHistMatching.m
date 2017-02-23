function imOut = myHistMatching ( input , reference )
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
end