function [foreground, img]= maskBackground(img, min_y_fore,max_y_fore,min_x_fore,max_x_fore)
foreground = [];
L = superpixels(img,500);
y_sp_fore=[max_y_fore;max_y_fore;min_y_fore;min_y_fore]';
x_sp_fore=[min_x_fore;max_x_fore;max_x_fore;min_x_fore]';

roi = poly2mask(x_sp_fore,y_sp_fore,size(L,1),size(L,2));
BW = grabcut(img,L,roi);
% BW = imcrop(img,x_sp_fore,y_sp_fore);
foreground= img;
foreground(repmat(~BW,[1 1 3])) = 0;
% foreground = fgTransparency(foreground)

img(repmat(BW,[1 1 3])) = 0;
img = inpaintExemplar(img,BW,'FillOrder','tensor');
end
