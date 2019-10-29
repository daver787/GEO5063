%load the time series data
load tnadata.txt;
load tsadata.txt;


%transform the time series data to a single column time series 
[TNA,T1]=yrmon2clm(tnadata(1:69,1:13));
[TSA,T2]=yrmon2clm(tsadata(1:69,1:13));

%plot the two transformed time series on the same plot
plot(T1,TNA,'Color','blue');
hold on
plot(T1,TSA,'Color','red');
axis([1946 2019 -1.5 1.5]);
grid
legend('TSA','TNA','Location','southeast');
xlabel('years');
ylabel('degrees Celsius');
title('Figure 1');

%make a scatter plot of TNA vs. TSA
figure
c='b'
scatter(TSA,TNA,'filled',c);
grid
refline
title('Figure 2')

%compute the correlation coefficent
[R,P,RL,RU] = corrcoef(TNA,TSA);
%correlation coefficent is significant since it is inside confidence
%interval

%critical correlation accounting for serial correlation
LLSE=ster(TSA,TNA);
RCRIT=2*LLSE
NSTAR=1/(LLSE^2)
%correaltion coefficent is not significant since it is below RCRIT


