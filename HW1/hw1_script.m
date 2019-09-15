%1)load the data.txt file
load data.txt;
i=transpose(1:828);
nino_3=data(:,5);
nino3_4=data(:,9);

%2)plot nino3 vs.time vector
plot(i,nino_3,'Color','blue');
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

%2)plot the max and min values for nino3
hold on
plot(index_max_nino3,max_nino3,'*','Color','black')
plot(index_min_nino3,min_nino3,'*','Color','black')
legend('nino3','nino3.4','max','min')
title('Figure 1')

% 3)compute a 2-panel plot of histogram of Nino3 using Matlab function
% histogram
figure
sgtitle('Figure 2')
subplot(2,1,1);
histogram(nino_3);
xlabel('Temperature(deg C)');
ylabel('Frequency');
subplot(2,1,2);
histogram(nino_3,28);
xlabel('Temperature(deg C)');
ylabel('Frequency');


%4)Create a scatter plot of Nino3.4(y-axis) vs Nino3(x-axis)
figure
scatter(nino_3,nino3_4);
axis([24 30 24 30])
xlabel('Nino3 Temperature');
ylabel('Nino 3.4 Temperature');
title('Figure 3');

%5) Create a one panel time series of SST anomalies
figure
nino_3_anom=data(:,6);
nino3_4_anom=data(:,10);
b1=plot(i,nino_3_anom,'Color','blue');
hold on
b2=plot(i,nino3_4_anom,'--','Color','red');
legend('nino3 anomalies','nino3.4 anomalies');
xlabel('Time(months)')
ylabel('Temperature(deg C)')
title('Figure 4');

%6) Create a one figure seasonal cycle from difference
figure
diff_nino3=nino_3-nino_3_anom;
diff_nino3_4=nino3_4-nino3_4_anom;
plot(i,diff_nino3,i,diff_nino3_4)
ylim([22,30])
xlabel('Time(months)')
ylabel(' difference SST(deg C)')
title('Figure 5');

%7)Create a map of the world using coastmap
figure
landscape();
coastmap([0 360 -60 60],40,'fill');
boxdraw([210,270,-5,5],'blue');
boxdraw([190,240,-5,5],'red','r--');
%legend('Nino 3','Nino 3.4')
title('Figure 6');
