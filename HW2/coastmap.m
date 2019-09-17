function coastmap(v,dxdy,fillseg)
%Function COASTMAP(V,DxDy,Fill) - Plot a filled-polygon coastline map
%   
%  Plots a filled-polygon map from the 50 km world coastline data. 
%  Uses an input axis vector V = [Lon1,Lon2,Lat1,Lat2] to plot a Lat-Lon
%  grid with dotted grid lines at Lat,Lon intervals <DxDy> & the dateline 
%  and equator solid. 
%
%  South latitudes are negative and longitudes must be expressed as degrees 
%  east of Greenwich. Lon1 should be less than Lon2, except when plotting 
%  across the Greenwich meridian. For example, to plot the Americas, 
%  V = [230,340,-50,50]. The landmass segments in the coastline map have been 
%  separated at 20E so that a complete map of the Atlantic can be made, 
%  including the western half of Africa. Hence the situation Lon1 >= Lon2 
%  can be handled if Lon2 <= 20. For example, V = [280,20,-50,50] will plot 
%  the entire width of the Atlantic. The default domain is V = [20,20,-80,80].
%
%  <DxDy> determines the Lat-Lon interval for drawing grid lines and axis 
%  labels. It defaults to 40 if there are no inputs at all, or to 20 otherwise.
%
%  Landmasses are gray-filled by default. If <Fill> == 'nofill', a 50-km  
%  coastline will be plotted but land areas will not be filled. 
%
%  None of the inputs are mandatory. world50.mat must be in the matlabpath.
%  The 50-km resolution may not be adequate for small regional maps. 

load world50               % Load the coastline data
col = [.85,.85,.85];          % Set the default fill color to gray
matver = version;          % Determine the Matlab version
lc = 'k'; lw = 1;          % Set color & linewidth of coastline
ddef = 20;                 % Set the default grid interval

% Parse the arguments
if nargin < 1 
	v = [20,20,-80,80]; dxdy = 2*ddef; fillseg = 'fill';
elseif nargin == 1, 
	if length(v)==4, dxdy = ddef; fillseg = 'fill'; 
	elseif isstr(v), fillseg = v; v = [20,20,-80,80]; dxdy = 2*ddef; 
	else, dxdy = v; v = [20,20,-80,80]; fillseg = 'fill'; end
elseif nargin == 2
	if length(v) == 4
		if isstr(dxdy), fillseg = dxdy; dxdy = ddef; else, fillseg = 'fill'; end
	else
		fillseg = dxdy; dxdy = v; v = [20,20,-80,80]; 
	end
end

% Fix a cross-Greenwich situation if it exists
if v(2) <= v(1) & v(2) <= 20
	jg = find(isnan(world50(:,1))==0);	
	jj = find(world50(jg,1)<=20);
	world50(jg(jj),1) = world50(jg(jj),1) + 360;
	v(2) = v(2) + 360;
end


% Plot filled polygon areas of world50
kk=find(isnan(world50(:,1))==1); nn = length(kk);
k1=[1;kk(1:nn-1)+1]; k2=kk-1; 
for k = 1:nn
	if strcmp(fillseg,'nofill') == 0 
		fill(world50(k1(k):k2(k),1),world50(k1(k):k2(k),2),col)
	end
	hold on; plot(world50(k1(k):k2(k),1),world50(k1(k):k2(k),2),...
		['-',lc],'linewidth',lw)   % Do coastlines
end

% Plot the equator, dateline and Greenwich
%plot([v(1),v(2)],[0,0],['-',lc],[180,180],...
%	[v(3),v(4)],['-',lc],[360,360],[v(3),v(4)],['-',lc])
	
lc2='k';   ! set color for equator and greenwich
plot([v(1),v(2)],[0,0],['-',lc2],[180,180],[v(3),v(4)],['-',lc2]);
plot([0,0],[v(3),v(4)],['-',lc2],[360,360],[v(3),v(4)],['-',lc2]);


% Set the grid
axis(v)
lons = [dxdy*ceil(v(1)/dxdy):dxdy:dxdy*floor(v(2)/dxdy)];
lats = [dxdy*ceil(v(3)/dxdy):dxdy:dxdy*floor(v(4)/dxdy)];
set(gca,'xtick',lons,'ytick',lats);
grid

% Create the axis labels
nl = length(lons); strx = [];
for k=1:nl
	if lons(k)<180
		strx = strvcat(strx,[int2str(lons(k)),'E']);
	elseif lons(k)==180
		strx = strvcat(strx,[int2str(lons(k))]);
	elseif lons(k)>360
		strx = strvcat(strx,[int2str(lons(k)-360),'E']);
	else
		strx = strvcat(strx,[int2str(360-lons(k)),'W']);
	end
end

nl = length(lats); stry = [];
for k=1:nl
	if lats(k)<0
		stry = strvcat(stry,[int2str(abs(lats(k))),'S']);
	elseif lats(k)==0
		stry = strvcat(stry,[int2str(lats(k))]);
	else
		stry = strvcat(stry,[int2str(lats(k)),'N']);
	end
end

% Place plot frame above the map
set(gca,'layer','top')

% Square the aspect ratio and set the axis labels
if strcmp(matver(1),'5')
	set(gca,'DataAspectRatio',[1,1,1]);
	set(gca,'xticklabel',strx,'yticklabel',stry)
elseif strcmp(matver(1),'9')
        set(gca,'DataAspectRatio',[1,1,1]);
        set(gca,'xticklabel',strx,'yticklabel',stry)
        set(gcf,'renderer','painter')
else
%	set(gca,'DataAspectRatio',[(v(2)-v(1))/(v(4)-v(3)),1])
 	set(gca,'DataAspectRatio',[(v(2)-v(1))/(v(4)-v(3)),1,1])
   
	set(gca,'xticklabels',strx,'yticklabels',stry)
end

%set(gca,'fontname','Palatino','fontsize',[18],'FontWeight','demi')
set(gca,'fontname','Palatino','fontsize',[15],'FontWeight','demi')
%xlabel('Longitude','fontsize',14,'fontweight','demi')
%ylabel('Latitude','fontsize',14,'fontweight','demi')
