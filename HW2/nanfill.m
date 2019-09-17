function z=nanfill(xx,miss)
% Function Z = NANFILL(X,MISS)
%  Replaces missing data in X (coded==MISS) with NaN's.

jj=find(xx==miss);
xx(jj)=nan*ones(size(jj));
z=xx;
