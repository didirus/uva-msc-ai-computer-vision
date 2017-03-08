Ia = imread('boat1.pgm');
Ib = imread('boat2.pgm');

% imshow(I,[])
Ia = single(Ia) ;
Ib = single(Ib) ;

[fa, da] = vl_sift(Ia) ;
[fb, db] = vl_sift(Ib) ;

[matches, scores] = vl_ubcmatch(da, db) ;


