function layers=segmentation(img,estimatedVertex)
% input: img:               the image under segmentation,
%        estimatedVertex:   12 reference point
%output: layers 5 cell of cropped image(RGB)
%functionality:segmentation of the input image, with specific 12 points,
%return 5 image after segmentation
    [m,n,p]=size(img);
    L = superpixels(img,500);
    mask1 = poly2mask(estimatedVertex(1,[1,2,8,7]),estimatedVertex(2,[1,2,8,7]),m,n);%back
    maskedImageBack = img;
    maskedImageBack(repmat(~mask1,[1 1 3])) = 0;
    figure(1)
    imshow(maskedImageBack)

    mask2 = poly2mask(estimatedVertex(1,[1,7,11,5]),estimatedVertex(2,[1,7,11,5]),m,n);%left
    maskedImageLeft = img;
    maskedImageLeft(repmat(~mask2,[1 1 3])) = 0;
    figure(2)
    imshow(maskedImageLeft)

    mask3 = poly2mask(estimatedVertex(1,[1,3,4,2]),estimatedVertex(2,[1,3,4,2]),m,n);%down
    maskedImageDown= img;
    maskedImageDown(repmat(~mask3,[1 1 3])) = 0;
    figure(3)
    imshow(maskedImageDown)

    mask4 = poly2mask(estimatedVertex(1,[2,8,12,6]),estimatedVertex(2,[2,8,12,6]),m,n);%right
    maskedImageRight = img;
    maskedImageRight(repmat(~mask4,[1 1 3])) = 0;
    figure(4)
    imshow(maskedImageRight)

    mask5 = poly2mask(estimatedVertex(1,[7,8,10,9]),estimatedVertex(2,[7,8,10,9]),m,n);%up
    maskedImageUp = img;
    maskedImageUp(repmat(~mask5,[1 1 3])) = 0;
    figure(5)
    imshow(maskedImageUp)

    layers ={maskedImageBack maskedImageLeft maskedImageDown maskedImageRight maskedImageUp };

end