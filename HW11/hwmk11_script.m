addpath m_map;
%1d)load data
load 12YearModelInterp.mat;

%1e)log transform the data
xnew2=log(xnew);;

%1f)compute the climatology
[anom,clim]=climavg(xnew2);

%1g)remove the temporal mean
xnew3=detrend(clim,'constant');

%1h)replace nans with zeros
idx=isnan(xnew3);
xnew3(idx)=0;

%2a)compute singular value decomposition
[U,S,V]=svd(xnew3);

%2b)compute the eigenvalues
Eval=diag(S.^2);

%2c)compute explained variance as an array
expl_var=(Eval/sum(Eval))*100;

%2d)compute EOF space patterns
EOFs=V;

%2e)compute the EOF  time series
EOFt=(U*S);

%3a) select the first two time series
EOFt1=EOFt(:,1);
EOFt2=EOFt(:,2);

%3b) plot both of the time series on the same plot
plot(EOFt1);
hold on;
plot(EOFt2);
title('Figure 1');

%3c)customize the axis and draw a grid
axis([1 12 -10 10]);
grid;

%3d) Label EOF time series as EOF1(X%) and EOF2(Y%)
EOF1_perc=expl_var(1);
EOF2_perc=expl_var(2);
legend('EOF1(68.30%)','EOF2(15.03%)');

%4a)Set inputs to m_datamap
dx=0.25;
dy=0.25;
v=[-98 -80 18 31];
cax=[-0.045 0.045];
ramp=1;

%4b)prepare data for m_datamap
xyz1=[lon' lat' EOFs(:,1)];
xyz2=[lon' lat' EOFs(:,2)];

%4c)Map EOF1 space pattern 
figure;
[h_surf,h_cbar]=m_datamap(xyz1,dx,dy,v,cax,ramp);
title('Figure 2');

%4d) As in 4c but for EOF2 space pattern
figure;
[h_surf,h_cbar]=m_datamap(xyz2,dx,dy,v,cax,ramp);
title('Figure 3')

%4e)What is the % variance explained by the first two EOFs combined?
perc_var=expl_var(1)+expl_var(2)

