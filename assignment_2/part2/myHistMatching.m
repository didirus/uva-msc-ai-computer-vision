function imOut = myHistMatching ( input , reference )

imOut = zeros(size(input))

[counts_I,binLocations_I] = imhist(input) ;
[counts_R,binLocations_R] = imhist(reference) ;

 % cumulative distributions
 
 c_input = cumsum(counts_I);
 c_ref = cumsum(counts_R);
 
 %normalize
 
 c_input = c_input ./ c_input(end) ;
 c_ref = c_ref ./ c_ref(end) ;
 
%  wiki : each gray level  G1 in [0,255], 
%  we find the gray level  G2, for which  
%  F1(G1)=F2(G2), and this is the result of histogram matching function:  
%  M(G1)=G2, Finally, we apply the function M() 
%  on each pixel of the reference image.
% For us
% M = array 
% F1 = c_input
% F2 = c_ref

F1 = c_input ;
F2 = c_ref;

M = zeros(size(F1));
g2 = 1;

for g1 = 1:length(M)
    flag = false;
    while(~flag)
        





 
 
 
 
 
 imOut = 0;
end

