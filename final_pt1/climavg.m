function [anom,clim] = climavg(x)
%Function [Anom,Clim] = climavg(X) -- Climatology & anomalies by average-month 
%  method. For M time series (length N) arranged as the columns of X, computes 
%  the monthly climatology and residuals -- Clim and Anom -- by averaging each  
%  successive month of the calendar year. Clim is returned as a 12-by-M matrix
%  and Anom is returned as a matrix with dimensions N-by-M (same as X). The
%  data (X) must begin in January. Correctly handles missing data coded as NaNs.
%
%  See also CLIMAVGN

[n,m] = size(x);
if n*m > 1000; cue=1; else; cue=0; end   % Monitor status
inc=12*(ceil(n/12)-n/12);
x=[x' nan*ones(m,inc)]';
[nr,nc]=size(x);nyrs=nr/12;

clim = zeros(12,nc); anom = zeros(12*nyrs,nc);
if cue == 1; h = waitbar(0,'Executing...'); end
for k=1:nc
	xx = reshape(x(:,k),12,nyrs)';
	clim(:,k) = meanmiss(xx)';
	anom(:,k) = x(:,k) - reshape(clim(:,k)*ones(1,nyrs),nr,1);
	if cue == 1; waitbar(k/nc); end
end

anom(n+1:nr,:) = [];
if cue == 1; close(h); end
