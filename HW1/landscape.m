function landscape(v)
% LANDSCAPE(V) - Sets GCF to print the current figure in landscape orientation.
%   If the vector V = [left_margin,bottom_margin,width,height] is specified 
%   (in inches), the figure will print on the corresponding part of the page. 
%   If V is not included, the full-page default is used: V = [0.5,0.5,10,7.5].
%   The figure window is specified to occupy 640 (wide) by 480 (tall) pixels
%   on the screen display. To avoid accidental resetting of properties (e.g.,
%   within called functions), this command can be given at the end of the 
%   calling routine that produces the plot. Be sure that the Page Setup com-
%   mand in the File menu is also set for the same orientation, prior to 
%   printing.

if nargin<1;v=[.5,.5,10,7.5];end
set(gcf,'PaperOrientation','landscape')
set(gcf,'PaperPosition',v,'PaperUnits','inches');
set(gcf,'Position',[50,100,fix(v(3)*640/10),fix(v(4)*480/7.5)],'Units','pixels')
