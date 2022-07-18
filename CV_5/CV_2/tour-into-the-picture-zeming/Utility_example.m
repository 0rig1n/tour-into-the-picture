clc
close all
clear
addpath(genpath('./')); 
image_name="./img/sagrada_familia.png";
img=imread(image_name);

mx=0;my=0.1;mz=0;rx=5;ry=2;rz=0;
min_y=739;max_y=1837;
min_x=1229;max_x=1729;


box=[min_y,max_y,min_x,max_x];
geo=[mx,my,mz,rx,ry,rz];
vanishing_point=[1000,1500]';
min_y_fore=1300;max_y_fore=1350;
min_x_fore=1300;max_x_fore=1350;


out=Tour_into_the_3d_picture(img,vanishing_point,box,min_y_fore,max_y_fore,min_x_fore,max_x_fore);
