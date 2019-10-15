function jj=findnot(x)
% FINDNOT finds the indices of the matrix X where the values ­ NaN.

jj=find(~isnan(x)==1);
