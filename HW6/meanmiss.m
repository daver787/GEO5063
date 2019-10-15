function m = meanmiss(x)
%MEANMISS Column matrix means with missing data.
%  MEANMISS(X) returns the means of the columns of X 
%  as a row vector, where missing data in X are encoded as NaN's.
%  Returns the same result as MEAN if there are no NaNs in X.

%m = nan*ones(1,length(x));
%jj = find(sum(finite(x)) ~= 0);
%if isempty(jj)==1, return, end

notvalid = isnan(x);
x(notvalid) = zeros(size(x(notvalid)));
denom = sum(1-notvalid);
if denom==0
	m = nan; return, 
elseif denom==1
	m = x; return
else
	m = sum(x)./denom;
end
