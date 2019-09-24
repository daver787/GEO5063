%load data and compute summary statistics
load data.txt;
nino_3=data(:,5);
nino_3_4=data(:,9);
nino_1_2=data(:,3);
stdev_nino3=std(nino_3);
mean_nino3=mean(nino_3);
var_nino3=var(nino_3);
sqrt_var_nino3=sqrt(var_nino3);
z_alpha_2=1.96

% 95 percent confidence interval calculation
lft_ci=mean_nino3-(z_alpha_2*stdev_nino3)/sqrt(length(nino_3));
rgt_ci=mean_nino3+(z_alpha_2*stdev_nino3)/sqrt(length(nino_3));
ci_interval=[lft_ci,rgt_ci];


%compute 95 percent confidence interval of sample variance of nino3
nu=length(nino_3)-1;
min_var=(nu*var_nino3)/chi2inv(0.975,nu);
max_var=(nu*var_nino3)/chi2inv(0.025,nu);

%compute histogram with normal distribution overlaid of nino3
histfit(nino_3);

%compute norm fit at 95 percent confidence interval for mean and standard
%deviation for nino3
[muHat_nino3,sigmaHat_nino3,muCI_nino3,sigmaCI_nino3]  =normfit(nino_3,.05);


[muHat_nino3_4,sigmaHat_nino3_4,muCI_nino3_4,sigmaCI_nino3_4]  =normfit(nino_3_4,.05);

[muHat_nino1_2,sigmaHat_nino1_2,muCI_nino1_2,sigmaCI_nino1_2]  =normfit(nino_1_2,.05);

[muHat_nino3_10,sigmaHat_nino3_10,muCI_nino3_10,sigmaCI_nino3_10]  =normfit(nino_3,.05);

