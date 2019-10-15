function [rsd,hrm] = harmanal(tim,dat)
%Function [Rsd,Hrm] = harmanal(Tim,Dat) -- Annual harmonic climatology
%
%  Compute a climatology from annual + two higher harmonics. Designed for
%  dealing with finer than monthly data (e.g., daily, pentads) distributed
%  over multiple years. Will accept missing data coded as NaNs but each
%  month of the year should have at least some data for best results.
%  The fitted climatology (Hrm, at original points) and the residuals (Rsd)
%  are output, and plots of the fits, data and residuals in three panels: 
%    1) calendar month averages (blue asterisks) and fitted harmonic 
%       climatology (red) over a single-year ensemble of all data, with
%       vertical bars at the ±stdev limits about the means; 
%    2) data time series (blue) & overplot of repeated harmonic climatology (red); 
%    3) time series of residuals (data minus climatology, green).
%
%  Calls HARM, HARMOUT


clf
tim2 = tim - floor(tim);
[tim2,i] = sort(tim2);
dat2 = dat(i);
for k = 1:12
	jj = find(tim2 > (k-1)/12 & tim2 <= k/12);
	tim3(k) = (k-0.5)/12;
	dat3(k) = meanmiss(dat2(jj));
	std3(k) = stdmiss(dat2(jj));
end

tim3 = [tim3,tim3+1,tim3+2,tim3+3,tim3+4,tim3+5,tim3+6,tim3+7];
dat3 = [dat3,dat3,dat3,dat3,dat3,dat3,dat3,dat3];
std3 = [std3(12),std3,std3(1)];

[xa3,aa3] = harm(tim3,dat3,1,3); 

subplot(3,1,1)
tim2 = 12.5 + tim2*12; 
plot(tim2,dat2,'.g'); hold on
plot([11:26],xa3(11:26),'r','linewidth',2);  
errorbar([12:25],dat3(12:25),std3,std3,'*b'); 
v1 = [11.5,25.5,floor(min(dat2(findnot(dat2)))),ceil(max(dat2(findnot(dat2))))];
plot([12.5,12.5],[v1(3),v1(4)],'w',[24.5,24.5],[v1(3),v1(4)],'w')

str = ['Dec';'   ';'Feb';'   ';'Apr';'   ';'Jun';'   ';'Aug';'   ';'Oct';'   ';'Dec';'   '];
set(gca,'xtick',[12:25],'xticklabels',str)
axis(v1); grid
str = input('Short Title for Plots: ');
title(['Harmonic Climatology for ',str])

xa = harmout(tim,aa3,1,meanmiss(dat));
subplot(3,1,2)
plot(tim,dat,'b'); hold on; plot(tim,xa,'r','linewidth',2)
title('Data and Climatology'); grid
v2 = axis; axis([v2(1),v2(2),v1(3),v1(4)])

subplot(3,1,3); 
rsd = dat-xa; hrm = xa;
plot(tim,rsd,'g',[tim(1),tim(length(tim))],[0,0],'-w')
title('Departures from the Climatology'); grid
axis([v2(1),v2(2),floor(min(rsd(findnot(rsd)))),ceil(max(rsd(findnot(rsd))))])
portrait

