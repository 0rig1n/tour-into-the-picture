function surface_3d(out)
[m,n,p]=size(out{1});
[X,Y] = meshgrid(1:n,1:m);
Z=zeros(m,n);
C=out{1};
h1=surface(X,Y,Z,C)
set(h1,'LineStyle','none')
hold on 

[m,n,p]=size(out{2});
[Z,Y] = meshgrid(-n:-1,1:m);
X=ones(m,n);
C=out{2};
h2=surface(X,Y,Z,C)
set(h2,'LineStyle','none')

[m,n,p]=size(out{3});[m1,n1,p1]=size(out{1});
[X,Z] = meshgrid(1:n,-m:-1);
Y=m1*ones(m,n);
C=out{3};
h3=surface(X,Y,Z,C)
set(h3,'LineStyle','none')

[m,n,p]=size(out{4});[m1,n1,p1]=size(out{1});
[Z,Y] = meshgrid(-n:-1,1:m);
X=n1*ones(m,n);
C=fliplr(out{4});
h4=surface(X,Y,Z,C)
set(h4,'LineStyle','none')

[m,n,p]=size(out{5});[m1,n1,p1]=size(out{1});
[X,Z] = meshgrid(1:n,-m:-1);
Y=ones(m,n);
C=fliplr(out{5});
h5=surface(X,Y,Z,C)
set(h5,'LineStyle','none')
end