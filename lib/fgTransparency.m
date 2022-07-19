function [I,alpha] = fgTransparency(I)
% input: img:               the image under segmentation,
%        estimatedVertex:   12 reference point
%output: layers 5 cell of cropped image(RGB)
%functionality:segmentation of the input image, with specific 12 points,
%return 5 image after segmentation
        alpha = ones(size(I,1),size(I,2));
        for i = 1 : size(I,1)
            for j = 1 :size(I,2)
                if I(i,j,1) <10 && I(i,j,2) <10  && I(i,j,3) <10 
                    alpha(i,j) = 0;
                end
            end
        end


end

