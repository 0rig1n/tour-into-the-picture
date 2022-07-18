function surfaceFG_3d(img,out,FGVertex,foreobj,test,pic_num)

transFG = fitgeotrans(FGVertex',foreobj([1,2],:)'/test,'projective');
min_x=min(FGVertex(1,:)');
max_x=max(FGVertex(1,:)');
min_y=min(FGVertex(2,:)');
max_y=max(FGVertex(2,:)');
p0=imref2d(size(img(min_y:max_y,min_x:max_x,:)));
p0.XWorldLimits=p0.XWorldLimits+min_x;
p0.YWorldLimits=p0.YWorldLimits+min_y;
[outputImage,p1] = imwarp(img(min_y:max_y,min_x:max_x,:),p0, transFG);
vec=[p1.XWorldLimits(1),p1.YWorldLimits(1)];
coord=ceil(foreobj([1,2],:)'/test-vec);
outFG=outputImage;

[m1,n1,p1] = size(out{1});
[m,n,p]=size(outFG);
nFG = (FGVertex(1,1):(FGVertex(1,2)-FGVertex(1,1))/(n-1):FGVertex(1,2))/test;
mFG = (m1-m:m/(m-1):m1);
[X,Y] = meshgrid(nFG,mFG);
Z=-foreobj(end,1)*ones(m,n)/test;
C=outFG;
h=surface(X,Y,Z,C);

set(h,'LineStyle','none')


end