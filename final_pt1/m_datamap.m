function [h_surf,h_cbar,xx,yy,cc] = m_datamap(xyz,dx,dy,v,cax,ramp,edge)

%  This function plots PCOLOR data with coastline map provided by M_MAP,
%  and returns the object handles of the surface plot and colorbar axes.
%  For an XYZ matrix = [Lon,Lat,Value], gives a pseudocolor plot of 2-D
%  scalar data with a land mask superimposed. DX and DY are the grid
%  spacings. Lat, Lon are assumed to be already laid out on an evenly
%  spaced grid.
%
%  The domain V is used in setting up the limits of the 'Miller' map
%  projection. Enter positive values for western longitudes,
%  i.e.  enter 190 for 170W.  V has several options:
%       V = [MinLon,MaxLon,MinLat,MaxLat] - explicitly uses the inputted
%                                           limits when setting up proj.
%                                           This format allows user to
%                                           specify non-world maps.
%       V = [CenLon,MinLat,MaxLat] - sets up a world map where CenLon = 
%                                    central longitude and MinLat, MatLat
%                                    are latitude limits.
%       V = [CenLon,MaxLat] -  sets up a world map where CenLon = central
%                              longitude, and MaxLat specifies limits in
%                              both N and S latitude.
%
%  The mandatory Cax vector will determine whether a colorbar will be added 
%  and what kind of color pallette scaling will occur over the image: 
%
%  If               pallette scaling is   colorbar is   for example:
%  ==============   ===================   ===========   ===================
%  Cax = [lo,hi]    as given by [lo,hi]   plotted       [-30,50], [-50,-30]
%  Cax = [hi,lo]    as given by [lo,hi]   not plotted   [50,-30], [-30,-50]
%  Cax =    1       [min,max] of data     plotted       
%  Cax =    0       [min,max] of data     not plotted   
%
%  If Ramp (optional) ~= 0, the colors are ramped (interpolated) across
%  the bins, giving a smoothed effect more suitable for presentation. 
%  If Ramp == 0 (DEFAULT), or is not specified, bins are constant-colored  
%  with faceted edges, giving a more accurate rendering of the actual data. 
%  Warning: Ramping causes data gaps to appear larger in the display unless 
%  they are first filled or interpolated.
%
%  The Edge (optional) parameter specifies the color of facet edges for
%  each cell. When Edge = 'flat' (DEFAULT), the edge lines match the color
%  of the cell, rendering the edges invisible. Otherwise Edge = color, i.e.
%   'w' or 'white' or [1 1 1]. Reference ColorSpec in Matlab help for more
%  info and additional colors.
%
%  Continents are filled by default. If either or both of dX,dY are
%  negative, only continental outlines are shown.
%
%  The colormap used is a "cold-to-hot" pallette by default. If the user
%  wishes to change the colormap, he can change CMAP under defaults, or he
%  can change it with Matlab's colormap function.
%
%  Uses calls to XYZ2MAT and M_MAP routines


%      DEFAULTS      %
% ------------------ %

% Function Parameters
h_surf  = []; h_cbar = [];
cfill  = true; % Indicate that coastlines are to be filled
barpos = 'EastOutside'; % Set colorbar position to outside right of axes
% cmap   = colormap(jet);
cmap   = flipud(hsv(256)); % Construct a "cold-to-hot" color pallette
cmap   = cmap(fix(32:3.5:255),:);

% Input Arguments
if nargin < 6, ramp = 0; edge = 'flat'; end
if nargin == 6
    if ischar(ramp) || length(ramp) > 1
        edge = ramp; ramp = 0;
    else
        edge = 'flat';
    end
end
if (dx<0 || dy<0), cfill = false; end


%    DATA MATRICIES    %
% -------------------- %

% Initiliaze map matrices using XYZ2MAT
[c,tmp,x,y] = xyz2mat(xyz,abs(dx),abs(dy));
nx = length(x); dx = mean(diff(x));
ny = length(y); dy = mean(diff(y));

% Pad the leftmost columns and bottommost rows
[nr,nc] = size(c);
c = flipud(c);   c = [c',nan*ones(nc,1)]';
c = fliplr(c);   c = [c,nan*ones(nr+1,1)];
if ramp ~= 0
	for k = 1:nc+1
		jj = findis(c(:,k)); 
		if jj(1)>1; c(jj(1),k) = c(jj(1)-1,k); end
	end
	c(nr+1,:) = c(ny,:);
	for k = 1:nr+1
		jj = findis(c(k,:));
		if jj(1)>1; c(k,jj(1)) = c(k,jj(1)-1); end
	end
	c(:,nc+1) = c(:,nx);
end
c = fliplr(c); c=flipud(c);
x = [x(1)-dx,x,x(nx)+dx];
y = [y(1)-dy,y,y(ny)+dy];

% Augment the data matrix to avoid truncation of raster plot
% and calculate grid definition vectors required by PCOLOR
[nr,nc] = size(c);
cc = [c nan*ones(nr,1)];            cc = [cc' nan*ones(nc+1,1)]';
x1 = x(1)-.5*dx; x2=x(nx+1)+.5*dx;  xx = x1:dx:x2;
y1 = y(1)-.5*dy; y2=y(ny+1)+.5*dy;  yy = y1:dy:y2;
if ramp ~= 0
    for k = 1:nr
        jg = find(isnan(cc(k,:)) == 0);
        cc(k,max(jg)+1) = cc(k,max(jg));
    end
    for k = 1:nc
        jg = find(isnan(cc(:,k))==0);
        cc(max(jg)+1,k) = cc(max(jg),k);
    end
	y1 = y(1); y2 = y(ny+1)+dy; yy = y1:dy:y2;
	x1 = x(1); x2 = x(nx+1)+dx; xx = x1:dx:x2;
end
%%%%%%%%% ADDED TO ORIGINAL CODE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This ensures that the sizes of cc & yy match
% Had a problem where yy had length 1 less than num of rows in cc, so added
% this section of code to fix the problem
if length(yy) - size(cc,1) == -1, yy = [yy,yy(end) + dy]; end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Specify projection parameters
params = numel(v); % count number of elem in v
switch params
    case 4
        while v(2) < v(1)
            if v(2) <= 0
                v(2) = v(2) + 360;
                continue
            end
            if v(1) > 180
                v(1) = v(1) - 360;
                continue
            end
            if v(1) <= 180 && v(2) <= 180
                v(2) = v(2) + 360;
                continue
            end
            break
        end
        if v(3) > v(4), v(3:4) = fliplr(v(3:4)); end
        m_proj('miller','lon',[v(1) v(2)],'lat',[v(3) v(4)])
    case 3
        if v(2) > v(3), v(2:3) = fliplr(v(2:3)); end
        m_proj('miller','lon',v(1),'lat',[v(2) v(3)])
    case 2, m_proj('miller','lon',v(1),'lat',v(2))
    otherwise
        disp(' !!!  Cannot initiate projection  !!!')
        disp('Input argument "v" contains < 2 elements')
        return
end

%    PLOT    %
% ---------- %
% Use m_pcolor to plot
if params < 4 % handle m_map quirks for the prime meridian
    h_surf(1) = m_pcolor(xx,yy,cc);        hold on;
    h_surf(2) = m_pcolor(xx - 360,yy,cc);  hold off;
    set(h_surf(1),'edgecolor',edge)
    set(h_surf(2),'edgecolor',edge)
else
    if v(1) < 0 || v(2) < 0
        ix = xx > 180;
        xx(ix) = xx(ix) - 360;
    end
    h_surf(1) = m_pcolor(xx,yy,cc);
    set(h_surf(1),'edgecolor',edge)
end
if ramp ~= 0, shading('interp'), end

% Setup c-axis and colorbar if needed
colormap(cmap);   % pallette = c2h, cth, gray, etc.
if length(cax) == 1
	if cax == 1, h_cbar = colorbar(barpos); end
else
	if cax(1) < cax(2); 
		caxis(cax);
		h_cbar = colorbar(barpos); 
	else
		caxis(fliplr(cax));
	end
end

% Plot the land mask
% if cfill, m_coast('patch',[0.9 0.9 0.9]);
% else m_coast('line','color','k','linewidth',1);
% end
if cfill, m_gshhs_i('patch',[0.9 0.9 0.9]);
else m_gshhs_i('line','color','k','linewidth',1);
end
m_grid;
