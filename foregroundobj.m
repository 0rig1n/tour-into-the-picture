function pixel_fore = foregroundobj(img,vanish_p,estimatedVertex,M)

% original coordination of foregroundobj
min_y_fore=1300;max_y_fore=1350;
min_x_fore=1300;max_x_fore=1350;

y_sp_fore=[max_y_fore;max_y_fore;min_y_fore;min_y_fore]';
x_sp_fore=[min_x_fore;max_x_fore;max_x_fore;min_x_fore]';


% 2D coordination
foreobj = [x_sp_fore; y_sp_fore];

x = estimatedVertex(1,5)-(estimatedVertex(2,5)-y_sp_fore(1))*(estimatedVertex(1,5)-x_sp_fore(1)) / (estimatedVertex(2,5)-estimatedVertex(2,1))
fore = [x;y_sp_fore(1)]

% 3D coordination
foreobj = [foreobj; zeros(1,4)];
L=zeros(12,1);

% Distance of vanish point and estimated vertex
for i=[1:12]
   L(i)=pdist([[vanish_p(2),vanish_p(1)]',estimatedVertex(:,i)]','euclidean');
end

% Find the z of the foregroundobj through the proportional relationship
K = pdist([[vanish_p(2),vanish_p(1)]',fore]','euclidean');

foreobj(3,:) = L(5) / K;

foreobj([1,2],:)=(foreobj([1,2],:)-[vanish_p(2),vanish_p(1)]').*foreobj(3,:);

foreobj([1,2],:)=foreobj([1,2],:)/1500;
transVertex_fore=transform(foreobj,M);
foreobj([1,2],:)=foreobj([1,2],:)*1500;
transVertex_fore([1,2],:)=transVertex_fore([1,2],:)*1500;
pixel_fore = toimgcoordinate(transVertex_fore);
origin_fore = toimgcoordinate(foreobj);
end