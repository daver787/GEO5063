function [b,rsq,pred] = regres1(xx,yy)
% Function [b,rsq,pred] = REGRES1(XX,YY)
%   Returns the simple linear regression of YY on XX
% 
%      XX = regression predictor          YY = predictand
%       b = [b1 b2] in y = b1 + b2*x     rsq = coef.det.
%    pred = b1 + b2*x                   pred = predictions
% 
%   XX,YY must be single-column vectors of same length. 
%   Data pairs with XX or YY missing (=NaN) are ignored. 

if length(xx) ~= length(yy); disp('Lengths don''t match'); return; end

pred = nan*ones(length(yy),1);

jj = find(yy~=nan & xx~=nan);
n = length(jj); x = ones(n,2);
x = xx(jj); y = yy(jj);

r = corrcoef([x y]); rsq = r(1,2)^2;
b2 = (sum(x.*y) - sum(x)*sum(y)/n)/(sum(x.^2) - sum(x).^2/n);
b1 = mean(y) - b2*mean(x);
b = [b1 b2];

pred(jj) = b1 + b2*xx;
