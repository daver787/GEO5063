function [y,t] = yrmon2clm(x,start,endd)

%Function [Y,T] = yrmon2clm(X,START,END)
%  On input, X is a rectangular matrix time series, e.g., years or
%  decades down and months or years across.  The first is assumed
%  to be a time labeler (e.g., year or decade). On output, <Y> 
%  is a single-column time series of the data contained to the
%  right of X(:,1). <T> becomes a single column vector of time 
%  units interpolated from the time labels in X(:,1).
%  START & END specify a subset of times (rows of X) to be output.
%  If less than three arguments enter, all rows are transformed. 
%
%  Reverse operation is done by CLM2YRMON

% Transform the X(START:END,2:NCOL) data into the Y vector
r1=1;c1=2;[r2,c2]=size(x);
if nargin==3
  r1=find(x(:,1)==start);
  r2=find(x(:,1)==endd);
end
npts=(c2-1)*(r2-r1+1);
y=reshape(x(r1:r2,c1:c2)',npts,1);

% Transform the X(START:END,1) data into the T vector
t1=x(r1,1);
delt=x(r2,1)-x(r2-1,1);
t2=x(r2,1)+delt;
t=t1:(t2-t1)/npts:t2-delt/(c2-1);
