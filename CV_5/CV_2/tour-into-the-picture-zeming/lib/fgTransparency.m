function img = fgTransparency(I)
        alpha = ones(size(I,1),size(I,2));
        for i = 1 : size(I,1)
            for j = 1 :size(I,2)
                if I(i,j,1) > 200 && I(i,j,2) > 200 && I(i,j,3) > 200 
                    alpha(i,j) = 0;
                end
            end
        end
        imwrite(I,'newImg.png','Alpha',alpha);
        img = imread('newImg.png')
end
