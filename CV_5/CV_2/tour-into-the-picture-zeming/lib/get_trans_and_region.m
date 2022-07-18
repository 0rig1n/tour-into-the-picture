function [trans,selected_region]=get_trans_and_region(estimatedVertex,ReferenceVertex)
trans=[];selected_region=[];
trans{1} = fitgeotrans(estimatedVertex(:,[1,2,8,7])',ReferenceVertex(:,[1,2,8,7])','projective');
selected_region{1}=[min(ReferenceVertex(:,[1,2,8,7])'),max(ReferenceVertex(:,[1,2,8,7])')];
trans{2} = fitgeotrans(estimatedVertex(:,[11,5,1,7])',ReferenceVertex(:,[11,5,1,7])','projective');
selected_region{2}=[min(ReferenceVertex(:,[11,5,1,7])'),max(ReferenceVertex(:,[11,5,1,7])')];
trans{3} = fitgeotrans(estimatedVertex(:,[1,3,4,2])',ReferenceVertex(:,[1,3,4,2])','projective');
selected_region{3}=[min(ReferenceVertex(:,[1,3,4,2])'),max(ReferenceVertex(:,[1,3,4,2])')];
trans{4} = fitgeotrans(estimatedVertex(:,[2,6,12,8])',ReferenceVertex(:,[2,6,12,8])','projective');
selected_region{4}=[min(ReferenceVertex(:,[2,6,12,8])'),max(ReferenceVertex(:,[2,6,12,8])')];
trans{5} = fitgeotrans(estimatedVertex(:,[7,8,10,11])',ReferenceVertex(:,[7,8,10,11])','projective');
selected_region{5}=[min(ReferenceVertex(:,[7,8,10,11])'),max(ReferenceVertex(:,[7,8,10,11])')];
end
