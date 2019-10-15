function [xa]=harmout(t,aa,f,xmean)

% Function [XA]=HARMOUT(t,aa,f,xmean)
%     Given the harmonic constants aa(m,complex) for the first m harmonics
%   of a series, and the basal frequency f (cycles per time unit),
%   returns the summed harmonic series, XA(t)=·A*exp(j2¹ft).  The user-
%   specified series mean <xmean> is added to the result.
%     Example: If the t-units are years, m=3 and the
%   basal frequency is f=1 cpy, the 3x2 complex vector aa(3) yields the annual 
%   cycle XA(t) for the combined 12-month, 6-month and 4-month periods.

j=sqrt(-1);max=length(aa);
xa=zeros(length(t),1);
arg=2*pi*f*t;
for m=1:max
  xa=xa+real(conj(aa(m))*exp(j*m*arg));
end
xa=xa+xmean;
