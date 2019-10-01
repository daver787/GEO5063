function  taxis = taxgen(dg1,dg2)
%Function taxis = taxgen(dg1,dg2)
%   Enter 4-digit integer date groups of the form DG = YYYYMM, for
%   the beginning and end of a monthly time period for which a time
%   axis (in fractional years) is to be generated. Calls DTG2YR.

y1=floor(dg1/100); m1=dg1-y1*100; % Parse to month & year
y2=floor(dg2/100); m2=dg2-y2*100; % Parse to month & year
nmos = (y2-y1)*12 + m2 - (m1-1);  % Compute no. of months
t1 = dtg2yr(y1,m1,15); 
t2 = dtg2yr(y2,m2,15);
taxis = t1:(t2-t1)/(nmos-1):t2;
taxis = taxis';
