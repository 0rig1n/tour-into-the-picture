function cloud=build_cloud(img,out,pic_num)
[m,n,p]=size(img);
cloud=zeros(6,m*n);
for i=[1:m]
    for j=[1:n]
        cloud(:,i+j*m)=[m/pic_num,n/pic_num,out(i,j),squeeze(img(i,j,:))']';
    end
end
end