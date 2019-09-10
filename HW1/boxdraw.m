function jpos = boxdraw(v,pos,col)
%Function jPos = boxdraw(V,Pos,Col) -- Extract position index &/or draw box
%  Can extract the indices jPos for Pos = [Lon,Lat] locations within the 
%  rectangular domain V = [MinLon,MaxLon,MinLat,MaxLat]. Specification of
%  the optional string matrix Col will trigger the drawing of a rectangular
%  box over a recently plotted map, outlining the domain V with a line of 
%  type/color = Col (e.g., '--w'). If the output jPos is not requested, only
%  a box will be drawn and only the V input is needed. 

jpos = []; hold on
[nr,nc] = size(v);
if nr>1; disp('Must have a domain vector (V)'); return; end

if nargin == 2
 [nr,nc] = size(pos);
 if nr==1; col = pos; pos = []; end
end

if nargout > 0; 
 jpos = find(pos(:,1)>v(1) & pos(:,1)<v(2) & pos(:,2)>v(3) & pos(:,2)<v(4));
end

if exist('col') == 1
 x = [v(1),v(1),v(2),v(2),v(1)]; 
 y = [v(3),v(4),v(4),v(3),v(3)];
 plot(x,y,col,'linewidth',2)
end
