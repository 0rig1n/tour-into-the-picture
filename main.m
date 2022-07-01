image_name="sagrada_familia.png"
img=imread(image_name);    
vanishing_point=[1000,1500]';
vanishing_point_after=[700,1200]';

min_y=800;max_y=1200;
min_x=1300;max_x=1700;
imshow(tour(img,vanishing_point,vanishing_point_after,min_y,max_y,min_x,max_x))