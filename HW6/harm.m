function [xa,aa]=harm(t,x,f,max,t1,t2)

% Function [XA,AA]=HARM(t,x,f,m,t1,t2)
%   Computes the harmonic constants AA(m,complex) for the first m harmonics
%   of the series x(t), given the basal frequency f (cycles per time unit).
%   Returns the harmonic constants AA(m) and the summed harmonic series, 
%   XA(t)=·AA*exp(j2¹ft).  Example: If the t-units are years, m=3 and the
%   basal frequency is f=1 cpy, the 3x2 complex vector AA(3) and the annual 
%   cycle XA(t) are returned for the 12-month, 6-month and 4-month periods.
%   If time limits t1,t2 are included, AA is computed only for the base period
%   x(t1²t²t2) and XA(t) is computed for the entire record and given a mean
%   value equal to the data mean for the entire record (t).  
%   
% Notes: XA is columnar but <t> or <x> can be rows or columns. <t> & <x> 
%        must be vectors and have equal lengths. Uses MEANMISS. Missing
%        data (coded == NaN) are accounted for. See: HARMOUT. 

j=sqrt(-1);
xa=zeros(length(x),1);
[nr,nc]=size(x); if nc>nr; x=x'; end
[nr,nc]=size(t); if nc>nr; t=t'; end
if nargin==6
	k=find(t >= t1 & t <= t2);
	tt=t(k);xx=x(k);
else
	tt=t;xx=x;
end

% kk=find(finite(xx)==1);
kk=find(isfinite(xx)==1);
xx=xx(kk); tt=tt(kk);
xmn=meanmiss(x);
n=length(xx);
nn=n/2-1;
arg1=2*pi*f*tt;
arg2=2*pi*f*t;
xx=xx/nn;
for m=1:max
  aa(m)=xx'*exp(j*m*arg1);
  xa=xa+real(conj(aa(m))*exp(j*m*arg2));
end
xa=xa+xmn;
