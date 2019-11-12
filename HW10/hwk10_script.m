addpath m_map;

%load the dataset
load 12YearModelInterp.mat

%construct a histogram of the raw data
figure
histogram(xnew,100)

%construct a second histogram with log transformed data
figure
log_transform=log(xnew);
histogram(log_transform,100);

%compute temporal mean using nanmean
temporal_mean=nanmean(xnew)

%make a color contour map using the procedure from hmwk 9
nx=numel(unique(lon));
ny=numel(unique(lat));

%convert arrays using reshape command
lon=reshape(lon,nx,ny);
lat=reshape(lat,nx,ny);
temporal_mean=reshape(temporal_mean,nx,ny);

%initialize the map projection and draw the color contours
figure
latlim=[18 31];
lonlim=[-98 -80];
m_proj('miller','lon',lonlim,'lat',latlim);
h_surf=m_pcolor(lon,lat,temporal_mean);
m_gshhs_f ('color','k');
shading interp
set(h_surf,'edgecolor','none')
set(gca,'fontsize',16,'fontweight','normal')
colormap('jet')

m_grid('ticklen',0.02,'linestyle','none');
cbar=colorbar('Location','EastOutside','YAxisLocation','right','fontsize',10,'fontweight','normal');
%label the colorbar as 'CHL(mg/m^3)'
ylabel(cbar,'CHL (mg/m^3)');



%Make a color contour map of the temporally averaged log-transformed
%chlorophyll data
temporal_mean_log=nanmean(log_transform);
temporal_mean_log=reshape(temporal_mean_log,nx,ny);
figure
latlim=[18 31];
lonlim=[-98 -80];
m_proj('miller','lon',lonlim,'lat',latlim);
h_surf=m_pcolor(lon,lat,temporal_mean_log);
m_gshhs_f ('color','k');
shading interp
set(h_surf,'edgecolor','none')
set(gca,'fontsize',16,'fontweight','normal')
colormap('jet')

m_grid('ticklen',0.02,'linestyle','none');
cbar=colorbar('Location','EastOutside','YAxisLocation','right','fontsize',10,'fontweight','normal');
%label the colorbar as 'CHL(mg/m^3)'
ylabel(cbar,'log[CHL (mg/m^3)]');
