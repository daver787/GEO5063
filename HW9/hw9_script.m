%add m_map folder to path
addpath m_map

%load file and create latitude,longitude and depth vectors from file data
file=load('etopo1_bedrock.xyz');
lon=file(:,1);
lat=file(:,2);
depth=file(:,3);

%determine number of unique latitude and longitude points
nx=numel(unique(lon));
ny=numel(unique(lat));

%convert 1-D arrays to 2-D arrays using reshape command
lon=reshape(lon,nx,ny);
lat=reshape(lat,nx,ny);
depth=reshape(depth,nx,ny);

%set all the values of array that are above sea level to zero
IX=depth>=0;
depth(IX)=0;

%initialize the map projection and draw the color contours
latlim=[18 31];
lonlim=[-98 -80];
m_proj('miller','lon',lonlim,'lat',latlim);
h_surf=m_pcolor(lon,lat,depth);
set(h_surf,'edgecolor','none')
set(gca,'fontsize',16,'fontweight','normal')
colormap('summer')

%plot the coastlines
m_gshhs_f('patch',[0.75 0.75 0.75],'edgecolor','none');
m_grid('ticklen',0.02,'linestyle','none');
cbar=colorbar('Location','EastOutside','YAxisLocation','right','fontsize',10,'fontweight','normal');
ylabel(cbar,'Depth (m)');
% 
% %plot the 200-m isobath as a black solid contour\
hold on
[C,h_cont]=m_contour(lon,lat,depth,[-200,-200]);
set(h_cont,'color','k','linewidth',0.5);