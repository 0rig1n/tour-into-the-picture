function pixel=toimgcoordinate(transVertex)
pixel=zeros(2,length(transVertex));
pixel(1,:)=transVertex(1,:)./transVertex(3,:);
pixel(2,:)=transVertex(2,:)./transVertex(3,:);
end