function [c,v,x,y] = xyz2mat(xyz,dx,dy)
%Function [c,v,x,y] = xyz2mat(XYZ,dX,dY) - Convert XYZ data to map matrix.
%  With data array XYZ = [Lon,Lat,Data_Value], find the matrix C whose
%  rows and columns correspond to the longitudes and latitudes for
%  the binning arrangement specified by BIN = [MinLon,MinLat,dX,dY],
%  where dX, dY are the grid spacings. Lat, Lon are assumed to be already
%  laid out on an evenly spaced grid. 
%
%  C = output map matrix, ordered such that PCOLOR(C,X,Y) gives a pseudo-
%  color plot in correct map orientation. Optional outputs are the domain V
%  and the X,Y bin coordinates, as required by COASTMAP(V) & DATAMAP(X,Y,V). 
%
%  Used by DATAMAP, COASTMAP

% Calculate the bin definition vector BIN
bin = [min(xyz(:,1)),min(xyz(:,2)),dx,dy];

% Calculate the Lon/Lat definition vectors for the map grid
[nr,nc]=size(xyz);
if nc > 3; disp('Warning: XYZ file has > 3 columns...'); end
mxln=max(xyz(:,1));
mxlt=max(xyz(:,2));
mxln=bin(3)*ceil((mxln-bin(1)-.5*bin(3))/bin(3))+bin(1);
mxlt=bin(4)*ceil((mxlt-bin(2)-.5*bin(4))/bin(4))+bin(2);
x = bin(1):bin(3):mxln;
y = bin(2):bin(4):mxlt;

% Compute the map domain vector V
v=[bin(1)-.5*bin(3),mxln+.5*bin(3),bin(2)-.5*bin(4),mxlt+.5*bin(4)];
if v(2) > 360; v(2)=v(2)-360; end

% Grid the data to a matrix in map layout
c = nan*ones(length(y),length(x));
indx = ((xyz(:,1)-bin(1))/bin(3))*length(y) + (xyz(:,2)-bin(2))/bin(4)+1; 
indx = round(indx); 
c(indx)=xyz(:,3);

% unvectorized version of line 35
%for k=1:nr
%	[dum,idx]=sort(abs(x-xyz(k,1))); i=idx(1);
%	[dum,idy]=sort(abs(y-xyz(k,2))); j=idx(1);
%	c(idy(1),idx(1))=xyz(k,3);
%end
