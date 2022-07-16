function out=name(estimatedVertex,recVertex,img)
out={};

trans{1} = fitgeotrans(estimatedVertex(:,[1,2,8,7])',recVertex([1,2],[1,2,8,7])'/10,'projective');
min_x=min(estimatedVertex(1,[1,2,8,7])');
max_x=max(estimatedVertex(1,[1,2,8,7])');
min_y=min(estimatedVertex(2,[1,2,8,7])');
max_y=max(estimatedVertex(2,[1,2,8,7])');
p0=imref2d(size(img(min_y:max_y,min_x:max_x,:)));
p0.XWorldLimits=p0.XWorldLimits+min_x;
p0.YWorldLimits=p0.YWorldLimits+min_y;
[outputImage,p1] = imwarp(img(min_y:max_y,min_x:max_x,:),p0, trans{1} );
vec=[p1.XWorldLimits(1)-0.5,p1.YWorldLimits(1)-0.5];
coord=ceil(recVertex([1,2],[1,2,8,7])'/10-vec);
out{1}=outputImage;

trans{2} = fitgeotrans(estimatedVertex(:,[11,5,1,7])',[recVertex([3],[11,5,1,7])',recVertex([2],[11,5,1,7])']/10,'projective');
min_x=min(estimatedVertex(1,[11,5,1,7])');
max_x=max(estimatedVertex(1,[11,5,1,7])');
min_y=min(estimatedVertex(2,[11,5,1,7])');
max_y=max(estimatedVertex(2,[11,5,1,7])');
p0=imref2d(size(img(:,min_x:max_x,:)));
[outputImage,p1] = imwarp(img(:,min_x:max_x,:),p0, trans{2} );
vec=[p1.XWorldLimits(1)-0.5,p1.YWorldLimits(1)-0.5];
coord=ceil(recVertex([3,2],[11,5,1,7])'/10-vec);
out{2}=outputImage(min(coord(:,2)):max(coord(:,2)),min(coord(:,1)):max(coord(:,1)),:);

trans{3} = fitgeotrans(estimatedVertex(:,[1,3,4,2])',[recVertex([1],[1,3,4,2])',recVertex([3],[1,3,4,2])']/10,'projective');
min_x=min(estimatedVertex(1,[1,3,4,2])');
max_x=max(estimatedVertex(1,[1,3,4,2])');
min_y=min(estimatedVertex(2,[1,3,4,2])');
max_y=max(estimatedVertex(2,[1,3,4,2])');
p0=imref2d(size(img(min_y:max_y,:,:)));
p0.YWorldLimits=p0.YWorldLimits+min_y-0.5;
[outputImage,p1] = imwarp(img(min_y:max_y,:,:),p0, trans{3} );
vec=[p1.XWorldLimits(1),p1.YWorldLimits(1)];
coord=ceil([recVertex([1],[1,3,4,2])',recVertex([3],[1,3,4,2])']/10-vec);
out{3}=outputImage(min(coord(:,2)):max(coord(:,2)),min(coord(:,1)):max(coord(:,1)),:);


trans{4} = fitgeotrans(estimatedVertex(:,[2,8,12,6])',[-recVertex([3],[2,8,12,6])',recVertex([2],[2,8,12,6])']/10,'projective');
min_x=min(estimatedVertex(1,[2,8,12,6])');
max_x=max(estimatedVertex(1,[2,8,12,6])');
min_y=min(estimatedVertex(2,[2,8,12,6])');
max_y=max(estimatedVertex(2,[2,8,12,6])');
p0=imref2d(size(img(:,min_x:max_x,:)));
p0.XWorldLimits=p0.XWorldLimits+min_x-0.5;
[outputImage,p1] = imwarp(img(:,min_x:max_x,:),p0, trans{4} );
vec=[p1.XWorldLimits(1),p1.YWorldLimits(1)-0.5];
coord=ceil([-recVertex([3],[2,8,12,6])',recVertex([2],[2,8,12,6])']/10-vec);
out{4}=outputImage(min(coord(:,2)):max(coord(:,2)),min(coord(:,1)):max(coord(:,1)),:);

trans{5} = fitgeotrans(estimatedVertex(:,[7,8,10,9])',[-recVertex([1],[7,8,10,9])',recVertex([3],[7,8,10,9])']/10,'projective');
min_x=min(estimatedVertex(1,[7,8,10,9])');
max_x=max(estimatedVertex(1,[7,8,10,9])');
min_y=min(estimatedVertex(2,[7,8,10,9])');
max_y=max(estimatedVertex(2,[7,8,10,9])');
p0=imref2d(size(img(min_y:max_y,:,:)));
[outputImage,p1] = imwarp(img(min_y:max_y,:,:),p0, trans{5} );
vec=[p1.XWorldLimits(1)-0.5,p1.YWorldLimits(1)-0.5];
coord=ceil([-recVertex([1],[7,8,10,9])',recVertex([3],[7,8,10,9])']/10-vec);
out{5}=outputImage(min(coord(:,2)):max(coord(:,2)),min(coord(:,1)):max(coord(:,1)),:);

