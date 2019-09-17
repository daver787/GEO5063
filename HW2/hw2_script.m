%load the data
ncdisp('data.nc')
lon=ncread('data.nc','X');
lat=ncread('data.nc','Y');
time=ncread('data.nc','T');
sst=ncread('data.nc','sst');
jansst=sst(:,:,1);
julysst=sst(:,:,7);

%fill the missing values with NaNs
miss=min(min(jansst));
jansstnan=nanfill(jansst,miss);
miss=min(min(julysst));
julysstnan=nanfill(julysst,miss);

%make the plot for january
h=pcolor(lon,lat,jansstnan');
set(h,'EdgeColor','none');
colorbar;
hold on
coastmap([min(lon),max(lon),min(lat),max(lat)],40)

%make the plot for july
figure
h=pcolor(lon,lat,julysstnan');

%compute the global mean
h=pcolor(lon,lat,julysstnan');
set(h,'EdgeColor','none');
colorbar;
hold on
coastmap([min(lon),max(lon),min(lat),max(lat)],40);

global_mean=mean(jansstnan,'all','omitnan');
global_mean2=mean(jansstnan,360,'omitnan');

