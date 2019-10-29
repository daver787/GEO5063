function llse = ster(X,Y)
%Function LLSE = ster(X,Y) -- Large-lag standard error of CCs
%  Compute the large-lag standard error of crosscorrelations.
%  Missing data codes as NaNs are set == zeros. Accepts X & Y
%  as vectors or as large matrices of equal size where corres-
%  ponding columns of X & Y yield a corresponding row element
%  in LLSE. 
%
%  X & Y are column vectors. The LLSE is computed (Davis, 1976) as  
%
%      StEr = sqrt(Acx'*Acy/N), where
%
%      Acx, Acy = 2-sided autocorrelation functions of X & Y
%             N = nominal degrees of freedom in series
%
%  Timing: 1000 pairs, N = 500 take 12 seconds on PowerMac G4/450
%  See:  Davis, R., J.Phys.Oceanogr., 6, 249-266, 1976
%  Calls ACORR (modified version of XCORR for autocorrelation)
%  D.B. Enfield, NOAA/AOML, June 2000

%t0 = clock;
if size(X,2) == 1 & size(Y,2) > 1
	X = X*ones(1,size(Y,2)); 
elseif size(X,2) ~= size(Y,2), 
	disp(['X & Y are not the same size or X is not a vector'])
end

X = X - ones(length(X(:,1)),1)*meanmiss(X);  % remove means of X
Y = Y - ones(length(Y(:,1)),1)*meanmiss(Y);  % remove means of Y
n = sum((1-isnan(X)).*(1-isnan(Y)));  % compute N for non-missing data
X = nan2miss(X,0); Y = nan2miss(Y,0); % convert any NaNs to zeros

cX = acorr(X);                % compute the autocorrelation of X
cY = acorr(Y);                % compute the autocorrelation of Y
llse = sqrt(sum(cX.*cY)./n);          % compute the standard error
%disp([etime(clock,t0)]); 

return
