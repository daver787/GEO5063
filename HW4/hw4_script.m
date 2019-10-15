 % Create a data set that uses the years 1981-2010
load data.txt
yr=data(:,1);
ikeep=find(yr>=1981 & yr<=2010);
dat=data(ikeep,:);

%plot the nino3 SST
nino3=dat(:,5);
time_vector=taxgen(198101,201012);
plot(time_vector,nino3);
axis([1980 2012 23 30]);

%compute the long term mean seasonal cycle for nino3 using the 30 year base
M= zeros(30,12);
count=1;
for i=(1:30)
    M(i,:)=nino3(count:(12*i));
    count=count+12;
end

%use repmeat to plot periodic seasonal cycle from 1981-2010
N=mean(M);
p=repmat(N,[1,30]);
figure;
plot(time_vector,p);
xlabel('Time(months)');
ylabel('SST(deg C)');
axis([1980 2012 23 30]);

%compute Nino3 SST anomaly time series by subtracting periodic trend
no_seasonal=(nino3'-p)';
figure;
plot(time_vector,no_seasonal);
xlabel('Time(months)');
ylabel('SST(deg C)');
axis([1980 2012 -2 4]);

%plot Nino3 anomaly time series and our computed anomaly time series on
%same plot
figure
nino3_anom=dat(:,6);
plot(time_vector,nino3_anom,'Color','red');
xlabel('Time(months)');
ylabel('SST(deg C)');
hold on
plot(time_vector,no_seasonal,'+','Color','blue');
axis([1980,2012,-2,-4]);
