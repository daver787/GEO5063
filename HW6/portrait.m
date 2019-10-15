function portrait(v)
% PORTRAIT(V) - Sets GCF to print the current figure in portrait orientation.
%   If the vector V = [left_margin,bottom_margin,width,height] is specified 
%   (in inches), the figure will print on the corresponding part of the page. 
%   If V is not included, the full-page default is used: V = [0.5,0.5,7.5,10].
%   The default figure window is specified to occupy 480 (wide) by 640 (tall) 
%   pixels on the screen display. To avoid accidental resetting of properties 
%   (e.g.,within called functions), this command can be given at the end of the 
%   calling routine that produces the plot. Be sure that the Page Setup com-
%   mand in the File menu is also set for the same orientation, prior to 
%   printing. On specified V, the screen window is resized in proportion to V. 

vd = [.5,.5,7.5,10];              % default figure size
if nargin < 1; v = vd; end
set(gcf,'PaperOrientation','portrait')
set(gcf,'PaperPosition',v,'PaperUnits','inches');
set(gcf,'Position',[v(1)*50/vd(1),v(2)*100/vd(2),v(3)*480/vd(3),v(4)*640/vd(4)],'Units','pixels')
