%load the dataset
load 12YearModelInterp.mat;

%plot the time series for grid point number 3000
igrid=3000;
y=xnew(:,igrid);
t=1:144;
plot(t,y,'b');
xlabel('Time (index number)');
ylabel('Chlorophyll(mg/m^3)');
title('Figure 1');

%plot a solid circle for every data point
hold on;
plot(t,y,'o','markerfacecolor','b');


%estimate chlorophyll at intermediate times by linear interploation and
%plot using red open circles
ti=1.5:1:143.5;
yi=interp1(t,y,ti);
hold on;
scatter(ti,yi,'r');

%repeat using spline interpolation and plot in same figure using green open
%circles
si=spline(t,y,ti);
hold on;
scatter(ti,si,'g');
legend('time series','original data points','linear interpolation','cubic spline interpolation');

%repeat original plot with line width equal to 2
figure;
plot(t,y,'linewidth',[2]);

%perform a 3 point running mean
ys3=movmean(y,3);

%plot the result as a red solid line with line width equal to 2
hold on;
plot(t,ys3,'r','linewidth',[2]);

%perform a 7 point running mean
ys7=movmean(y,7);

%plot the result as a green solid line with line width equal to 2
hold on;
plot(t,ys7,'g','linewidth',[2]);
xlabel('Time (index number)');
ylabel('Chlorophyll(mg/m^3)');
title('Figure 2');
legend('No smoothing','3 point moving average','7 point moving average');