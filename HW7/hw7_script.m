%Create a 3 by 3 matrix and compute the average
%5 different ways
A=[NaN NaN NaN; 1 2 NaN; 2 3 4];
%method 1
method_1=mean(mean(A));
%method 2
method_2=meanmiss(meanmiss(A));
%method 3
method_3=mean(A(:));
%method_4
method_4=meanmiss(A(:))
%method 5
sum=0;n=0;
for i=1:3
    for j=1:3
        if (isnan(A(i,j))~=1);
        sum=sum+A(i,j);    
            n=n+1;
        end
    end
end
av=sum/n

% Compute and plot the lagged autocorrelation with itself of Nino3 SST for
% lags -40 to 40
load data.txt
nino3=data(:,5);
nino3_anom=data(:,6);
[ccxy]=ccorr(40,nino3,nino3)
lags=ccxy(:,1);
cf=ccxy(:,2);
figure
plot(lags,cf)
xlabel('lags')
ylabel('autocorrelation value')
title('Figure 1')
axis([-80 80 -0.8 1.2])
grid

%repeat the process with Nino3 SST anomalies
[ccxy]=ccorr(40,nino3_anom,nino3_anom)
lags_anom=ccxy(:,1);
cf_anom=ccxy(:,2);
figure
plot(lags_anom,cf_anom)
xlabel('lags')
ylabel('autocorrelation value')
title('Figure 2')
axis([-80 80 -0.4 1.2])
grid