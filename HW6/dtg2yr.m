function year=dtg2yr(yr,mo,da)

% Function YEAR=DTG2YR(yr,mo,da)
%   Given the year, month and day of an observation, the fractional
%   year is returned, e.g., DTG2YR(86,5,23)=1986.3918.  When t1 & t2
%   are thus computed from the dates for the start and end of a 
%   series, the time axis for plotting daily data computes as
%
%              taxis=t1:(t2-t1)/(npts-1):t2,
%
%   where npts is the number of observations in the series.  If one
%   desires to index all times in taxis up to a certain date,
%
%              index=find(taxis<=yrtim(yr,mo,da)).
%
%   Leap years are accounted for.  
%
%   See TAXGEN for automated time axis generation (monthly data)

modays=[0 31 59 90 120 151 181 212 243 273 304 334];
yrdays=365; ndays=modays(mo)+da;
if rem(yr,4)==0 & mo>=3; ndays=ndays+1; yrdays=yrdays+1; end
year=yr+(ndays-.5)/yrdays;
