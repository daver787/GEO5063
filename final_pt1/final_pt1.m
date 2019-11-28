%1a)load data
load 12YearModelInterp.mat;

%1b)log transform the data
xnew2=log(xnew);

%1c)apply climavg function
[anom,clim]=climavg(xnew2);


%replace NANs with zeros
idx=isnan(anom);
anom(idx)=0;

%2a)make a map of the standard deviation of the log-transformed chlorophyll
%anomalies
std_anoms=std(anom)
dx=0.25;
dy=0.25;
v=[-98 -80 18 31];
cax=[-0.045 0.045];
ramp=1;

%2b)prepare data for m_datamap
xyz1=[lon' lat' std_anoms'];


%2c)call the mapping function
figure;
[h_surf,h_cbar]=m_datamap(xyz1,dx,dy,v,cax,ramp);
title('Figure 1');



%3) Compute the EOFs of the anomalies using the Singular Value Decompos
%ition

%3a)Compute percent variance,EOF space time patterns and EOF time series
%but for the anomalies
[U,S,V]=svd(anom);

%3b)compute the eigenvalues
Eval=diag(S.^2);

%3c)compute EOF space patterns
EOFs=V;

%3d)compute the EOF  time series
EOFt=(U*S);

%3e) select the first two time series
EOFt1=EOFt(:,1);
EOFt2=EOFt(:,2);

%3c) compute the explained variance as an array
expl_var=(Eval/sum(Eval))*100;

%3d)plot the first variance explained in percent for each EOF mode(Y-axis)
%versus EOF mode number(X-axis) using a continuous solid line joining '*'
%symbols
figure;
plot(expl_var(1:30),'LineStyle','-','Marker','*');
title('Figure 2');
xlabel('EOF mode number');
ylabel('Variance explained (%)');

%3e)Compute the total cumulative variance explined by the first two modes
two_modes_variance=expl_var(1)+expl_var(2);

%4)Plot the first two EOF time series of the anomalies

%Use a time vector generated by taxgen to plot the first two EOF time
%series
time_vec=taxgen(199801,200912)
%Make a two panel plot with first EOF time series in upper panel and
%second EOF time series on the lower panel
figure;
sgtitle('First two EOF modes');
subplot(2,1,1)
plot(time_vec,EOFt1);
xticks(1998:1:2010);
yticks([-5 0 5]);
ylim([-10,10]);
grid
title('EOF mode 1');

subplot(2,1,2)
plot(time_vec,EOFt2);
xticks(1998:1:2010);
yticks([-5 0 5]);
ylim([-10,10]);
grid
title('EOF mode 2');

%5)Plot the first two EOF space patterns of the anomalies using m_datamap
%5a)prepare data for m_datamap
xyz1=[lon' lat' EOFs(:,1)];
xyz2=[lon' lat' EOFs(:,2)];

%5b)Map EOF1 space pattern 
figure;
subplot(1,2,1);
[h_surf,h_cbar]=m_datamap(xyz1,dx,dy,v,cax,ramp);
title('EOF space pattern 1');

%5c)MapEOF2 space pattern
subplot(1,2,2);
[h_surf,h_cbar]=m_datamap(xyz2,dx,dy,v,cax,ramp);
title('EOF space pattern 2')






