%% ---- local helper functions ----

function plot_nullcline_contour(xg,yg,F,style)
% Plot the contour F(x,y)=0 on a precomputed grid.
    C = contour(xg,yg,F,[0 0],style,'LineWidth',1.4);
    if isempty(C), return; end %#ok<NASGU>
end
