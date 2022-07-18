function [FGVertex,foreobj] = foregroundobj(img,vanishing_point,estimatedVertex,min_y_fore,max_y_fore,min_x_fore,max_x_fore)

% original coordination of foregroundobj
% min_y_fore=1300;max_y_fore=1350;
% min_x_fore=1300;max_x_fore=1350;
pic_num=ceil(max(size(img(:,:)))/5);
min_y_fore = floor(min_y_fore);
min_x_fore = floor(min_x_fore);
max_y_fore = floor(max_y_fore);
max_x_fore = floor(max_x_fore);

y_sp_fore=[max_y_fore;max_y_fore;min_y_fore;min_y_fore]';
x_sp_fore=[min_x_fore;max_x_fore;max_x_fore;min_x_fore]';

FGVertex = [min_x_fore max_x_fore max_x_fore min_x_fore;
    max_y_fore max_y_fore min_y_fore min_y_fore]


% 2D coordination
foreobj = [x_sp_fore; y_sp_fore];

x = estimatedVertex(1,5)-(estimatedVertex(2,5)-y_sp_fore(3))*(estimatedVertex(1,5)-estimatedVertex(1,1)) / (estimatedVertex(2,5)-estimatedVertex(2,1));

fore = [x;y_sp_fore(1)];

% 3D coordination
foreobj = [foreobj; zeros(1,4)];
L=zeros(12,1);

% Distance of vanish point and estimated vertex
for i=[1:12]
   L(i)=pdist([[vanishing_point(1),vanishing_point(2)]',estimatedVertex(:,i)]','euclidean');
end

% Find the z of the foregroundobj through the proportional relationship
K = pdist([[vanishing_point(1),vanishing_point(2)]',fore]','euclidean');

y_ref = max(estimatedVertex(2,5),estimatedVertex(2,3));
y_cut = (y_sp_fore(1)+y_sp_fore(3))/2;
foreobj(3,:) =abs(y_cut-vanishing_point(1))/abs(y_ref-vanishing_point(1));

% foreobj(3,:) =max(L(5),L(3))/K;
foreobj(3,:) 
foreobj([1,2],:)=(foreobj([1,2],:)-[vanishing_point(1),vanishing_point(2)]').*foreobj(3,:);
foreobj(3,:) = foreobj(3,:)*pic_num;

end





