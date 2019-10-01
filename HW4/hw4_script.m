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
count=1
for i=(1:30)
    M(i,:)=nino3(count:(12*i));
    count=count+12;
end 

N=mean(M)
P=repmat(N,[1,30]);
figure;
plot(time_vector,P);
axis([1980 2012 23 30]);