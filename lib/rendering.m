function out=rendering(layers,estimatedVertex,ReferenceVertex)
% input: layers:            5 cell images after segmentation,
%        estimatedVertex:   12 reference point before perspective
%        transformation
%        ReferenceVertex:   12 reference point after perspective
%        transformation
% output: one RGB image, the image after perspective transformation
%functionality: 1. Apply perspective to each cell, according to the
%                  reference point
%               2. Aggregate 5 layers into one image(image size should be 
%                  determined by min-max value along x-y axis of ReferenceVertex)
%return 1 image after synthesis 
end