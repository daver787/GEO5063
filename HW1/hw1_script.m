%load the data.txt file
load data.txt;
i=transpose(1:828);
nino_3=data(:,5);
nino3_4=data(:,9);

%plot nino3 vs.time vector
plot(i,nino_3);
xlabel('Time(months)')
ylabel('SST(deg C)')
hold on
plot(i,nino3_4,'--','Color','red')
ylim([22,30])

[max_nino3,index_max_nino3]=max(nino_3);
[max_nino34,index_max_nino34]=max(nino3_4);
[min_nino3,index_min_nino3]=min(nino_3);
[min_nino34,index_min_nino34]=min(nino3_4);
range_nin03=max_nino3-min_nino3;
range_nin034=max_nino34-min_nino34;

%plot the max and min values for nino3
hold on
plot(index_max_nino3,max_nino3,'*','Color','black')
plot(index_min_nino3,min_nino3,'*','Color','black')
legend('nino3','nino3.4','max','min')
title('SST over time')

% compute a 2-panel plot of histogram of Nino3 using Matlab function
% histogram
figure
subplot(2,1,1);
histogram(nino_3);
xlabel('Temperature(deg C)');
ylabel('Frequency');
subplot(2,1,2);
histogram(nino_3,28);
xlabel('Temperature(deg C)');
ylabel('Frequency');

%Create a scatter plot of Nino3.4(y-axis) vs Nino3(x-axis)
figure
scatter(nino_3,nino3_4);
axis([24 30 24 30]);
