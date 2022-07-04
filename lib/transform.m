function transVertex=transform(recVertex,M)
[m,n]=size(recVertex);
transVertex=M*[recVertex;ones(1,n)];
end