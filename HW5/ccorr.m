function [ccxy,st] = ccorr(lag,x,y,b_str)
%Function [CCxy,StEr] = ccorr(Lag,X,Y,'biasing')
%  Calculates the crosscorrelation function of X & Y, from -Lag to +Lag
%  or the autocorrelation function of X  when X = Y or Y is missing.  
%  X & Y must be equally dimensioned column vectors, dimensioned equally.
%  On output, CCxy = [LAGS,CF], where CF is the correlation function and
%  LAGS = -Lag : Lag.  X leads Y for positive lags. 
%
%  The large-lag standard error of CF is an option estimated by STER.
%  The estimated 90%, 95%, etc. significance levels for CCxy are
%  correspondingly estimated as 1.7*StEr, 2.0*StEr, etc.
%
%  For 'biasing' = 'biased'   ==> values normalized by series length 1/M
%                = 'unbiased' ==> values normalized by 1/(M-abs(lag))
%       Default  = 'biased'
%
%  Notes: 
%  1) Any NaNs are replaced by zeros. This can produce distortions of 
%     the amount of missing data is "large".
%  2) Computing StEr takes more time than CCxy. In repetitive use,
%     it may be better to not request StEr as output, and make 
%     a separate estimate using STER with representative data samples. 
%
%  Makes calls to STER, MEANMISS, STDMISS, NAN2MISS

% Check & correct the input conditions

% Parse the input arguments
if nargin == 3
	if isstr(y)
		b_str = y; 
		y = x; 
	else 
		b_str = 'biased';
	end
elseif nargin < 3
	y = x; 
	b_str = 'biased';
end
fac=0; if length(b_str) >6; fac=1; end

[nx,mx]=size(x); if nx < mx; x=x'; [nx,mx]=size(x); end
[ny,my]=size(y); if ny < my; y=y'; [ny,my]=size(y); end
if mx>1; disp('Inputs can only be vectors (one column only)'); return; end
if my>1; disp('Inputs can only be vectors (one column only)'); return; end
if nx~=ny; disp('Input vectors must be of same length'); return; end

% Demean, remove NaN's and initialize the lag matrix for Y
x = x-meanmiss(x); y = y-meanmiss(y);     % Demean the data
x = x/stdmiss(x);  y = y/stdmiss(y);      % Normalize
x = nan2miss(x,0); y = nan2miss(y,0);     % Any NaNs to zeros

% Compute the outputs
lags = -lag:1:lag; 

if lag <= 32
	ls = zeros(nx,lag);         % Initialize left  side of expanded yy matrix
	rs = zeros(nx,lag);         % Initialize right side of expanded yy matrix

% Fill out the expanded lag-matrix of Y (yy)
	for k=1:lag
		nmk = nx-k;
		ls(k+1:nx,k) = y(1:nmk);
		rs(1:nmk,k) = y(k+1:nx);
	end
	ls = fliplr(ls); 
	yy = [ls,y,rs];

% Compute the outputs
	ccxy = [lags',(x'*yy./(nx-fac*lags))'];
else
	ccxy = xcorr(x,y,b_str);
	ccxy = [lags',ccxy((nx-lag):(nx+lag))];
end

% If required, compute the large-lag standard error
if nargout == 2; st = ster(x,y); end
