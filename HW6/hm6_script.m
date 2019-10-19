%load the data
load data.txt
%estimate the harmonic climatology of Nino3 SST
nino3=data(:,5);
nino3_anom=data(:,6);
time_vector=taxgen(195001,201612);
[rsd,hrm]=harmanal(time_vector,nino3);
%Make comparison plot of Nino3 SST anomalies using harmonic analysis versus
%LTMSC
figure
plot(time_vector,rsd,'Color','blue');
hold on
plot(time_vector,nino3_anom,'-','Color','red');
title('Figure 2')
axis([1950 2016 -2 4]);
%Make a comparison time series plot of Nino3 SST  seasonal cycle from
%derived from harmonic analysis and the Nino3 LTMSC
figure
ltmsc_nino3=nino3-nino3_anom
plot(time_vector,hrm,'Color','red')
hold on
plot(time_vector,ltmsc_nino3,'Color','blue')
title('Figure 3')
axis([1950 1952 22 30])

