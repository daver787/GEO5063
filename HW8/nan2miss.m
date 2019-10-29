function z=nan2miss(x,miss)
% Function Z = NAN2MISS(X,MISS)
%  Replaces NaN's in X with missing data values (coded==MISS).

x(isnan(x)) = miss*ones(size(x(isnan(x))));
z=x;
