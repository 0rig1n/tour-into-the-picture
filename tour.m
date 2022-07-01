function out=tour(img,vanishing_point,vanishing_point_after,min_y,max_y,min_x,max_x)
    image_name="sagrada_familia.png"
    img=imread(image_name);
    [m,n,p]=size(img);
    x_max = n;
    y_max = m;
    vanishing_point=[1000,1500]';
    vanishing_point_after=[700,1200]';

    min_y=800;max_y=1200;
    min_x=1300;max_x=1700;

    x_vp=vanishing_point(2);
    y_vp=vanishing_point(1);

    y_sp=[max_y;max_y;min_y;min_y];
    x_sp=[min_x;max_x;max_x;min_x];

    x_sp = [x_sp ; x_sp(1)];
    y_sp = [y_sp ; y_sp(1)];

    for i =1:4
        gradient(i) = (y_sp(i)-y_vp)/(x_sp(i)-x_vp);
    end
    plot(x_sp,y_sp,'b')
    estimatedVertex = zeros(2,12);
    estimatedVertex(:,1) = [x_sp(1);y_sp(1)];
    estimatedVertex(:,2) = [x_sp(2);y_sp(2)];
    estimatedVertex(:,8) = [x_sp(3);y_sp(3)];
    estimatedVertex(:,7) = [x_sp(4);y_sp(4)];

    estimatedVertex(:,3) = [(y_max-y_vp)/gradient(1) + x_vp; y_max];
    estimatedVertex(:,5) = [0; (0-x_vp)*gradient(1) + y_vp];
    estimatedVertex(:,4) = [(y_max-y_vp)/gradient(2) + x_vp; y_max];
    estimatedVertex(:,6) = [x_max; (x_max-x_vp)*gradient(2) + y_vp];
    estimatedVertex(:,10) = [(0-y_vp)/gradient(3) + x_vp; 0];
    estimatedVertex(:,12) = [x_max; (x_max-x_vp)*gradient(3) + y_vp];
    estimatedVertex(:,9) = [(0-y_vp)/gradient(4) + x_vp; 0];
    estimatedVertex(:,11) = [0; (0-x_vp)*gradient(4) + y_vp];
    imshow(img)
    hold on 
    %find 3 vertex need padding, padding them
    k_left=vanishing_point(2)/(vanishing_point(2)-min_x);
    k_up=vanishing_point(1)/(vanishing_point(1)-min_y)
    k_down=(m-vanishing_point(1))/(max_y-vanishing_point(1));
    k_right=(n-vanishing_point(2))/(max_x-vanishing_point(2));
    scale=max([k_left,k_up,k_down,k_right]);


    bound=[vanishing_point(2)-scale*(vanishing_point(2)-min_x)+1,     vanishing_point(2)+scale*(max_x-vanishing_point(2));
        vanishing_point(1)-scale*(vanishing_point(1)-min_y)+1,vanishing_point(1)+scale*(max_y-vanishing_point(1))]%[boundxmin,boundxmax;boundymin,boundymax]
    %(out) bound will not move during transform
    %padding(if pad left or up,pad should add to coordinate)
    pad_left=1-bound(1,1);
    pad_down=bound(2,2)-m;
    pad_right=bound(1,2)-n;
    pad_up=1-bound(2,1);
    img=padarray(img,[pad_up,pad_left],0,'pre');img=padarray(img,[pad_down,pad_right],0,'post');
    %update coorinate
    bound(1,:)=bound(1,:)+pad_left;bound(2,:)=bound(2,:)+pad_up;
    vanishing_point_after=vanishing_point_after+[pad_up,pad_left];
    min_y=800+pad_up;max_y=1200+pad_up;
    min_x=1300+pad_left;max_x=1700+pad_left;

    %cal new box bound(via scale since it is not changeing during transoform)
    %spawm the box after,it's vertce indicate the transform
    new_min_y=vanishing_point_after(1)-(vanishing_point_after(1)-bound(2,1))/scale;
    new_max_y=vanishing_point_after(1)+(bound(2,2)-vanishing_point_after(1))/scale;
    new_min_x=vanishing_point_after(2)-(vanishing_point_after(2)-bound(1,1))/scale;
    new_max_x=vanishing_point_after(2)+(bound(1,2)-vanishing_point_after(2))/scale;

     Vertex(:,1)=[ min_x, max_y];
     Vertex(:,2)=[ max_x, max_y];
     Vertex(:,3)=[ max_x, min_y];
     Vertex(:,4)=[ min_x, min_y];
     Vertex(:,5)=[bound(1,1),bound(2,2)];
     Vertex(:,6)=[bound(1,2),bound(2,2)];
     Vertex(:,7)=[bound(1,2),bound(2,1)];
     Vertex(:,8)=[bound(1,1),bound(2,1)];


    new_Vertex(:,1)=[new_min_x,new_max_y];
    new_Vertex(:,2)=[new_max_x,new_max_y];
    new_Vertex(:,3)=[new_max_x,new_min_y];
    new_Vertex(:,4)=[new_min_x,new_min_y];
    new_Vertex(:,5)=[bound(1,1),bound(2,2)];
    new_Vertex(:,6)=[bound(1,2),bound(2,2)];
    new_Vertex(:,7)=[bound(1,2),bound(2,1)];
    new_Vertex(:,8)=[bound(1,1),bound(2,1)];

    %mask the image, do transform
    [m,n,p]=size(img);
    mask(:,:,1)=poly2mask(Vertex(1,[1,2,3,4]),Vertex(2,[1,2,3,4]),m,n);%mid
    mask(:,:,2)=poly2mask([bound(1,1),bound(1,1),min_x,min_x],[bound(2,2),bound(2,1),min_y,max_y],m,n);%left
    mask(:,:,3)=poly2mask([bound(1,1),bound(1,2),max_x,min_x],[bound(2,2),bound(2,2),max_y,max_y],m,n);%down
    mask(:,:,4)=poly2mask([max_x,max_x,bound(1,2),bound(1,2)],[min_y,max_y,bound(2,2),bound(2,1)],m,n);%right
    mask(:,:,5)=poly2mask([min_x,max_x,bound(1,2),bound(1,1)],[min_y,min_y,bound(2,1),bound(2,1)],m,n);%up
    imshow(mask(:,:,1))

    layer=uint8(zeros(m,n,p,5));
    for i=[1:5]
        underprocess=img;
        underprocess(~cat(3,mask(:,:,i),mask(:,:,i),mask(:,:,i)))=0;
        layer(:,:,:,i)=underprocess;
    end
    %assemble the transformation for each layer
    trans=[];
    trans{1} = fitgeotrans(Vertex(:,[1,2,3,4])',new_Vertex(:,[1,2,3,4])','affine');
    trans{2} = fitgeotrans(Vertex(:,[8,5,1,4])',new_Vertex(:,[8,5,1,4])','affine');
    trans{3} = fitgeotrans(Vertex(:,[5,6,2,1])',new_Vertex(:,[5,6,2,1])','affine');
    trans{4} = fitgeotrans(Vertex(:,[6,7,3,2])',new_Vertex(:,[6,7,3,2])','affine');
    trans{5} = fitgeotrans(Vertex(:,[7,8,4,3])',new_Vertex(:,[7,8,4,3])','affine');
    out=uint8(zeros(m,n,p));

    pit=[];
    for i=[1:5]
        %subplot(5,1,i);
        p0=imref2d(size(layer(:,:,:,i)));
        [outputImage,p1] = imwarp(layer(:,:,:,i),p0, trans{i} );

        pit{i}=p1;
        switch i
            case 1
                temp=outputImage(new_min_y+p0.YWorldLimits(1)-p1.YWorldLimits(1):new_max_y+p0.YWorldLimits(1)-p1.YWorldLimits(1),new_min_x-p1.XWorldLimits(1)+p0.XWorldLimits(1):new_max_x-p1.XWorldLimits(1)+p0.XWorldLimits(1),:);
                out(new_min_y:new_max_y,new_min_x:new_max_x,:)=temp;
            case 2
                temp=outputImage((bound(2,1)-p1.YWorldLimits(1)+p0.YWorldLimits(1)):(bound(2,2)-p1.YWorldLimits(1)+p0.YWorldLimits(1)),(bound(1,1)-p1.XWorldLimits(1)+p0.XWorldLimits(1)):(new_max_x+p0.XWorldLimits(1)-p1.XWorldLimits(1)),:);
                out(bound(2,1):bound(2,2),bound(1,1):new_max_x,:)=out(bound(2,1):bound(2,2),bound(1,1):new_max_x,:)+temp;
            case 3
                temp=outputImage(new_max_y-p1.YWorldLimits(1)+p0.YWorldLimits(1):bound(2,2)-p1.YWorldLimits(1)+p0.YWorldLimits(1),bound(1,1)-p1.XWorldLimits(1)+p0.XWorldLimits(1):bound(1,2)-p1.XWorldLimits(1)+p0.XWorldLimits(1),:);
                out(new_max_y:bound(2,2),bound(1,1):bound(1,2),:)=out(new_max_y:bound(2,2),bound(1,1):bound(1,2),:)+temp;
            case 4
                temp=outputImage(bound(2,1)-p1.YWorldLimits(1)+p0.YWorldLimits(1):bound(2,2)-p1.YWorldLimits(1)+p0.YWorldLimits(1),new_max_x-p1.XWorldLimits(1)+p0.XWorldLimits(1):bound(1,2)-p1.XWorldLimits(1)+p0.XWorldLimits(1),:);
                out(bound(2,1):bound(2,2),new_max_x:bound(1,2),:)=temp+out(bound(2,1):bound(2,2),new_max_x:bound(1,2),:);
            case 5
                temp=outputImage(bound(2,1)-p1.YWorldLimits(1)+p0.YWorldLimits(1):new_min_y-p1.YWorldLimits(1)+p0.YWorldLimits(1),bound(1,1)-p1.XWorldLimits(1)+p0.XWorldLimits(1):bound(1,2)-p1.XWorldLimits(1)+p0.XWorldLimits(1),:);
                out(bound(2,1):new_min_y,bound(1,1):bound(1,2),:)=temp+out(bound(2,1):new_min_y,bound(1,1):bound(1,2),:);
        end
    end
end