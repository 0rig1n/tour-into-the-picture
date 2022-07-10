function [out,estimatedVertex_after]=padding(img,origin,estimatedVertex)
[m,n,p]=size(img);
size_before=1+max(origin')-min(origin');
shift_origin=min(origin');
estimatedVertex_after=ceil(1+origin'-shift_origin);estimatedVertex_after=estimatedVertex_after';

pad_left=estimatedVertex_after(1,1)-estimatedVertex(1,1);
pad_up=estimatedVertex_after(2,1)-estimatedVertex(2,1);
pad_right=size_before(1)-n-pad_left;
pad_down=size_before(2)-m-pad_up;
out=padarray(img,[pad_up,pad_left],0,'pre');out=padarray(out,[pad_down,pad_right],0,'post');
end