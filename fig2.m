%% FigS1_geometry.m
% Supporting Information Figure S1
% Circular-segment geometry and mixed boundary conditions.
%
% Geometry:
%   H = h/R_p = 1 - cos(alpha)
%
% Boundary conditions:
%   Gamma_w : U_FS = 0
%   Gamma_s : dU_FS/dn = 0
%
% Publication-ready vector/raster export.

clear; clc; close all;

%% ------------------------------------------------------------------------
%  Global graphics settings
% -------------------------------------------------------------------------
set(groot, ...
    'defaultAxesFontName','Arial', ...
    'defaultTextFontName','Arial', ...
    'defaultAxesFontSize',14, ...
    'defaultTextFontSize',14);

%% ------------------------------------------------------------------------
%  Representative geometry
% -------------------------------------------------------------------------
H     = 1.35;               % representative filling ratio
alpha = acos(1-H);          % H = 1 - cos(alpha)
Rp    = 1.0;                % plotting radius

% Free-surface elevation and intersection
yfs = -cos(alpha);
xfs =  sin(alpha);

% Complete pipe
th = linspace(0,2*pi,1200);
xc = Rp*cos(th);
yc = Rp*sin(th);

%% ------------------------------------------------------------------------
%  Wetted circular arc
%
%  Right intersection:
%       theta_R = alpha - pi/2
%
%  Left intersection:
%       theta_L = 3*pi/2 - alpha
%
%  The wetted wall is the LOWER/Major circular arc from left to right.
% -------------------------------------------------------------------------
thetaL = 3*pi/2 - alpha;
thetaR = 3*pi/2 + alpha;

thWet = linspace(thetaL,thetaR,1200);

xWet = Rp*cos(thWet);
yWet = Rp*sin(thWet);

% Wetted-region polygon:
% circular wetted wall + horizontal free-surface chord
xPoly = [xWet, xWet(1)];
yPoly = [yWet, yWet(1)];

%% ------------------------------------------------------------------------
%  Figure
% -------------------------------------------------------------------------
fig = figure( ...
    'Color','w', ...
    'Units','centimeters', ...
    'Position',[1 1 16 16.0], ...
    'Renderer','painters');

ax = axes(fig,'Position',[0.02 0.02 0.98 0.98]);
hold(ax,'on');
axis(ax,'equal');
axis(ax,'off');

%% ------------------------------------------------------------------------
%  Wetted liquid region
% -------------------------------------------------------------------------
patch(ax,xPoly,yPoly,[0.88 0.92 0.97], ...
    'EdgeColor','none', ...
    'FaceAlpha',1);

%% ------------------------------------------------------------------------
%  Pipe outline
% -------------------------------------------------------------------------
plot(ax,xc,yc,'k-', ...
    'LineWidth',1.20);

% Wetted wall: slightly stronger than remaining pipe outline
plot(ax,xWet,yWet,'k-', ...
    'LineWidth',3.05);

% Free surface
plot(ax,[-xfs xfs],[yfs yfs],'k--', ...
    'LineWidth',4.0);

%% ------------------------------------------------------------------------
%  Pipe centre
% -------------------------------------------------------------------------
plot(ax,0,0,'ko', ...
    'MarkerFaceColor','k', ...
    'MarkerSize',4.2);

%% ------------------------------------------------------------------------
%  Geometrical construction lines
% -------------------------------------------------------------------------

% Radius from centre to right free-surface intersection
plot(ax,[0 xfs],[0 yfs],'k--', ...
    'LineWidth',1.85);

% Downward vertical radius used to define alpha
plot(ax,[0 0],[0 -1],'k--', ...
    'LineWidth',1.85);

%% ------------------------------------------------------------------------
%  Coordinate axes located EXACTLY at pipe centre
% -------------------------------------------------------------------------
axisLength = 0.58;
headLength = 0.035;
headWidth  = 0.017;

% X axis
plot(ax,[0 axisLength],[0 0],'k-', ...
    'LineWidth',0.85);

drawArrowHead(ax,[axisLength 0],[1 0],headLength,headWidth);

% Y axis
plot(ax,[0 axisLength*0],[0 axisLength],'k-', ...
    'LineWidth',0.85);

drawArrowHead(ax,[0 axisLength],[0 1],headLength,headWidth);

% Coordinate labels
text(ax,axisLength+0.035,-0.015,'$X$', ...
    'Interpreter','latex', ...
    'FontSize',18, ...
    'HorizontalAlignment','left', ...
    'VerticalAlignment','middle');

text(ax,0.012,axisLength+0.035,'$Y$', ...
    'Interpreter','latex', ...
    'FontSize',18, ...
    'HorizontalAlignment','left', ...
    'VerticalAlignment','bottom');

%% ------------------------------------------------------------------------
%  Filling angle alpha
% -------------------------------------------------------------------------
rArc = 0.30;

% alpha measured from downward vertical radius
phi = linspace(-pi/2,-pi/2+alpha,300);

plot(ax,rArc*cos(phi),rArc*sin(phi),'k-', ...
    'LineWidth',1.90);

% alpha label
phiMid = -pi/2 + alpha/2;

text(ax, ...
    1.3*rArc*cos(phiMid), ...
    1.3*rArc*sin(phiMid), ...
    '$\alpha$', ...
    'Interpreter','latex', ...
    'FontSize',18, ...
    'HorizontalAlignment','center', ...
    'VerticalAlignment','middle');

%% ------------------------------------------------------------------------
%  Radius label
% -------------------------------------------------------------------------
rLabel = 0.72;

xr = rLabel*xfs;
yr = rLabel*yfs;

% Small offset normal to the radius
er = [xfs yfs];
er = er/norm(er);
en = [-er(2) er(1)];

offsetR = 0.055;

text(ax, ...
    xr + offsetR*en(1), ...
    yr + offsetR*en(2), ...
    '$R_p$', ...
    'Interpreter','latex', ...
    'FontSize',18, ...
    'HorizontalAlignment','center', ...
    'VerticalAlignment','middle');

%% ------------------------------------------------------------------------
%  Water-depth dimension h
% -------------------------------------------------------------------------
xd = -1.18;

% Extension lines
extLen = 0.055;

plot(ax,[xd-extLen xd+extLen],[-1 -1],'k-', ...
    'LineWidth',0.80);

plot(ax,[xd-extLen xd+extLen],[yfs yfs],'k-', ...
    'LineWidth',0.80);

% Dimension line
plot(ax,[xd xd],[-1 yfs],'k-', ...
    'LineWidth',0.80);

% Compact arrowheads
dimHeadL = 0.060;
dimHeadW = 0.027;

% Bottom arrow points downward to y = -1
drawArrowHead(ax,[xd -1],[0 -1],dimHeadL,dimHeadW);

% Top arrow points upward to y = yfs
drawArrowHead(ax,[xd yfs],[0 1],dimHeadL,dimHeadW);

% h label
text(ax,xd-0.075,(yfs-1)/2,'$h$', ...
    'Interpreter','latex', ...
    'FontSize',18, ...
    'HorizontalAlignment','right', ...
    'VerticalAlignment','middle');

%% ------------------------------------------------------------------------
%  Boundary labels
% -------------------------------------------------------------------------

% Free-surface boundary condition
text(ax,-0.40,yfs+0.070, ...
    '$\Gamma_s:\ \partial U_{\rm FS}/\partial n=0$', ...
    'Interpreter','latex', ...
    'FontSize',18, ...
    'HorizontalAlignment','center', ...
    'VerticalAlignment','bottom');

% Wetted-wall boundary condition
%
% Put the label close to the lower-right wall but not directly on the line.
thetaLab = -42*pi/180;

xLab = 0.60*cos(thetaLab);
yLab = 0.84*sin(thetaLab);

text(ax,xLab,yLab, ...
    '$\Gamma_w:\ U_{\rm FS}=0$', ...
    'Interpreter','latex', ...
    'FontSize',18, ...
    'HorizontalAlignment','center', ...
    'VerticalAlignment','middle', ...
    'Rotation',-43);
text(ax,-0.5,-0.8, '$\Omega$', ...
    'Interpreter','latex', ...
    'FontSize',18, ...
    'HorizontalAlignment','center', ...
    'VerticalAlignment','middle')

%% ------------------------------------------------------------------------
%  Geometry relation
% -------------------------------------------------------------------------
% text(ax,0,1.17, ...
%     '$H=h/R_p=1-\cos\alpha$', ...
%     'Interpreter','latex', ...
%     'FontSize',12, ...
%     'HorizontalAlignment','center', ...
%     'VerticalAlignment','middle');

%% ------------------------------------------------------------------------
%  Limits
% -------------------------------------------------------------------------
xlim(ax,[-1.34 1.18]);
ylim(ax,[-1.15 1.27]);

%% ------------------------------------------------------------------------
%  Export
% -------------------------------------------------------------------------
% exportgraphics(fig,'FigS1_geometry.pdf', ...
%     'ContentType','vector');

exportgraphics(fig,'FigS1_geometry.png', ...
    'Resolution',600);

fprintf('Saved FigS1_geometry.pdf and FigS1_geometry.png\n');


%% ========================================================================
%  Local function: compact publication-style arrowhead
% ========================================================================
function drawArrowHead(ax,tip,direction,L,W)

    direction = direction/norm(direction);

    % Perpendicular direction
    normal = [-direction(2), direction(1)];

    % Base centre
    base = tip - L*direction;

    % Triangle corners
    p1 = tip;
    p2 = base + W*normal;
    p3 = base - W*normal;

    patch(ax, ...
        [p1(1) p2(1) p3(1)], ...
        [p1(2) p2(2) p3(2)], ...
        'k', ...
        'EdgeColor','k');

end
