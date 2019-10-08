%Load the data and make a time series plot of Nino 3.4 and Nino1+2
load data.txt
anom_3_4=data(:,10);
anom_1_2=data(:,4);
time_vector=taxgen(195001,201612);
plot(time_vector,anom_3_4,'Color','red');
hold on
plot(time_vector,anom_1_2,'--','Color','blue');
legend('nino3.4 anomalies','nino1+2 anomalies');
axis([1940 2020 -4 4]);
xlabel('Time(years)')
ylabel('Temperature difference (deg C)')
title('Figure 1');

%Create a scatter plot of Nino 1+2 anomalies(y-axis) vs. Nino3.4
%anomalies(x-axis)
figure
scatter(anom_3_4,anom_1_2)
xlabel('Nino 3.4 anomalies')
ylabel('Nino 1+2 anomalies')
title('Figure 2')

%Compute a regression line (Nino 1+2 anomalies)=a+b(Nino3.4 anomalies) and
%print out the coefficents a and b.
 [b,rsq,pred]=regres1(anom_3_4,anom_1_2)
y_int=b(1)
slope=b(2)
y_int
slope
hold on
plot(anom_3_4,y_int+slope*anom_3_4)

%compute the lagged cross-correlation coefficent between Nino3.4 and
%nino1.2 anomaly time series for lags -10 to 10
figure
[ccxy]=ccorr(10,anom_3_4,anom_1_2);
lag=ccxy(:,1);
correlation=ccxy(:,2);
plot(lag,correlation)
xlabel('Lag')
ylabel('Cross-Correlation')
title('Figure 3')
