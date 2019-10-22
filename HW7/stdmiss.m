function sd = stdmiss(x)
%STDMISS Column matrix standard deviations with missing data.
%  STDMISS(X) returns the standard deviations of the columns of X 
%  as a row vector, where missing data in X are encoded as NaN's.
%  Returns the same result as STD if there are no NaNs in X.

notvalid = isnan(x);
x(notvalid) = zeros(size(x(notvalid)));
n = sum(1-notvalid);
sd = sqrt((sum(x.^2)-(sum(x).^2)./n)./(n-1));
