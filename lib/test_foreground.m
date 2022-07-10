RGB = imread('uhren-turm.jpg');

L = superpixels(RGB,500);
imshow(RGB)
h1 = drawpolygon;
roiPoints = h1.Position;
roi = poly2mask(roiPoints(:,1),roiPoints(:,2),size(L,1),size(L,2));
BW = grabcut(RGB,L,roi);
imshow(BW)
maskedImage = RGB;
maskedImage(repmat(~BW,[1 1 3])) = 0;
imshow(maskedImage)