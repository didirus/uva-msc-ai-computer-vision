edit for 2D Gaussian: <br />
Convolved_2D = gaussConv(I,1,1,5);<br />
Convolved_2D = int8(Convolved_2D);<br /><br />
function [ imOut ] = gaussConv( image , sigma_x , sigma_y , kernel_size )<br />
Gauss_H = gauss(sigma_x^2,kernel_size);<br />
Gauss_V = gauss(sigma_y^2,kernel_size);<br />
Gauss_V = Gauss_V' ;<br />
imOut = conv2(Gauss_H,Gauss_V,image);<br />
end<br /><br />
## Computer-Vision Lab Assignments

### Week 1: Matlab tutorial (no files)

### Week 2:  (matlab files and report)
**Photometric Stereo**<br />
Albedo, Integrability, Height-map, Surface-normals graph
<br />
**Color Spaces**<br />
Convert an RGB-image into the (1) Opponent, (2) Normalized RGB, (3) HSV, (4) YCbCr Color Space and 4 types of Grayscale.
<br />
<br />
Tushar Nimbharkar & Diede Rusticus<br />
Computer Vision '17<br />
Artificial Intelligence Master<br />
University of Amsterdam
