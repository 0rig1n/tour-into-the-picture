function out=Tour_into_the_picture(img,vanishing_point,box,geo)
%img image under invest
%vanishing_point(y,x)
%box [min_y,max_y,min_x,max_x]
%geo: geometric transformation parameter :[mx,my,mz,rx,ry,rz];
[m,n,p]=size(img);
x_max = n;
y_max = m;

mx=geo(1);my=geo(2);mz=geo(3);rx=geo(4);ry=geo(5);rz=geo(6);

min_y=box(1);max_y=box(2);
min_x=box(3);max_x=box(4);
%1250  1850 1650 750
x_vp=vanishing_point(2);
y_vp=vanishing_point(1);

y_sp=[max_y;max_y;min_y;min_y];
x_sp=[min_x;max_x;max_x;min_x];

x_sp = [x_sp ; x_sp(1)];
y_sp = [y_sp ; y_sp(1)];

for i =1:4
    gradient(i) = (y_sp(i)-y_vp)/(x_sp(i)-x_vp);
end

estimatedVertex = zeros(2,12);
estimatedVertex(:,1) = [x_sp(1);y_sp(1)];
estimatedVertex(:,2) = [x_sp(2);y_sp(2)];
estimatedVertex(:,8) = [x_sp(3);y_sp(3)];
estimatedVertex(:,7) = [x_sp(4);y_sp(4)];

estimatedVertex(:,3) = [(y_max-y_vp)/gradient(1) + x_vp; y_max];
estimatedVertex(:,5) = [0; (0-x_vp)*gradient(1) + y_vp];
estimatedVertex(:,4) = [(y_max-y_vp)/gradient(2) + x_vp; y_max];
estimatedVertex(:,6) = [x_max; (x_max-x_vp)*gradient(2) + y_vp];
estimatedVertex(:,10) = [(0-y_vp)/gradient(3) + x_vp; 1];
estimatedVertex(:,12) = [x_max; (x_max-x_vp)*gradient(3) + y_vp];
estimatedVertex(:,9) = [(0-y_vp)/gradient(4) + x_vp; 1];
estimatedVertex(:,11) = [0; (1-x_vp)*gradient(4) + y_vp];

recVertex=reconst3d(vanishing_point,estimatedVertex);

M=[rotx(rx)*roty(ry)*rotz(rz),[mx,my,mz]';zeros(1,3),1];
recVertex([1,2],:)=recVertex([1,2],:)/1500;
transVertex=transform(recVertex,M);
recVertex([1,2],:)=recVertex([1,2],:)*1500;
transVertex([1,2],:)=transVertex([1,2],:)*1500;
pixel=ceil(toimgcoordinate(transVertex));
origin=ceil(toimgcoordinate(recVertex));
%out=rendering(i,origin,pixel)
[img,estimatedVertex]=padding(img,origin,estimatedVertex);
layers=segmentation(img,estimatedVertex);
out=rendering(layers,origin,pixel,vanishing_point);


end