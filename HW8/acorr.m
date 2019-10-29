function [c,lags] = acorr(a, maxlag)
%Function [c,lags] = acorr(A, MaxLag) -- Autocorrelation functions
%  Produces the two-sided autocorrelation functions of the columns
%  of A(N,M). If MaxLag is not specified, MaxLag = size(A,1)-1. The 
%  autocorrelation functions are normalized to = 1 at lag = 0. Gives
%  an identical result to the diagonal (i.e., CC(:,[1,M+2,2M+3,...])
%  of CC = XCORR(A,MaxLag,'coeff').
%
%  Uses the Fourier transform (FFT/IFFT) method.
%  D.B. Enfield, NOAA/AOML, June 2000

if  nargin == 1
    maxlag = size(a,1)-1;
end

[nr, nc] = size(a);
nsq  = nc^2;
mr = 2 * maxlag + 1;
nfft = 2^nextpow2(mr);
nsects = ceil(2*nr/nfft);
if nsects>4 & nfft<64
   nfft = min(4096,max(64,2^nextpow2(nr/4)));
end

pp = 1:nc;
n1 = pp(ones(nc,1),:);  n2 = n1';

c = zeros(nfft,nc); 
minus1 = (-1).^(0:nfft-1)' * ones(1,nc);
af_old = zeros(nfft,nc);
n1 = 1;
nfft2 = nfft/2;
while( n1 < nr )
   n2 = min( n1+nfft2-1, nr );
   af = fft(a(n1:n2,:), nfft);
   c = c + af.* conj( af + af_old );
   af_old = minus1.*af;
   n1 = n1 + nfft2;
end;
if  n1==nr
   af = ones(nfft,1)*a(nr,:);
   c = c + af.* conj( af + af_old );
end
c = ifft(c);

mxlp1 = maxlag+1;
c = [ conj(c(mxlp1:-1:2,:)); c(1:mxlp1,:)];

tmp = c(mxlp1,:);
cdiv = ones(length(c(:,1)),1)*tmp;
c = c ./ cdiv;

if ~any(any(imag(a)))
   c = real(c);
end
lags = [-maxlag:maxlag];
