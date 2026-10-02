%% Fig3_boundary_mechanism_fields_updated_R2019b.m
% Exact DCR fields at three filling ratios.
%
% Rows:
%   1. Physical velocity U_FS
%   2. Poisson driving field U_D
%   3. Confinement magnitude C = -U_C
%   4. Release magnitude R = U_R
%
% Complete pipe outlines are kept identical in size;
% only the wetted region is color filled.
%
% Each subplot is labeled (a)--(l).
%
% MATLAB R2019b compatible version.
%
% Compatibility modifications:
%   1. turbo(256) -> turboR2019b(256)
%   2. exportgraphics -> print
%   3. More conservative figure/axes syntax
%
% Output:
%   Fig3_boundary_mechanism_fields_updated.png
%
% Optional:
%   Fig3_boundary_mechanism_fields_updated.pdf

clear;
clc;
close all;


%% ----------------------- Global appearance -----------------------------

set(groot,'defaultAxesFontName','Arial');
set(groot,'defaultTextFontName','Arial');

set(groot,'defaultAxesFontSize',14);
set(groot,'defaultTextFontSize',14);


%% --------------------------- Parameters --------------------------------

Hs = [0.30 1.00 1.80];

stateLab = {'I','II','III'};

ns    = 101;
nxi   = 241;
nk    = 600;

xiMax = 6.0;
kMax  = 10.0;


%% ------------------------ Calculate fields -----------------------------

D(1) = dcrField(Hs(1),ns,nxi,nk,xiMax,kMax);

for j = 2:numel(Hs)

    D(j) = dcrField(Hs(j),ns,nxi,nk,xiMax,kMax);

end


%% ---------------- Reference physical velocity --------------------------

% Reference velocity based on the maximum physical
% velocity over all three cases.

Uref = max(arrayfun(@(z) max(z.UFS(:)),D));


%% ---------------- Common color scale -----------------------------------

% Use one common normalized color scale for all four rows.

allMax = 0;

for j = 1:3

    thisMax = max( ...
        [ ...
        D(j).UFS(:); ...
        D(j).UD(:); ...
        D(j).C(:); ...
        D(j).R(:) ...
        ] ...
        ) / Uref;

    allMax = max(allMax,thisMax);

end


%% --------------------------- Figure ------------------------------------

fig = figure( ...
    'Color','w', ...
    'Units','centimeters', ...
    'Position',[1 1 32 32], ...
    'Renderer','opengl' ...
    );


% R2019b-compatible print setup

set(fig,'PaperUnits','centimeters');

set(fig,'PaperPosition',[0 0 32 32]);

set(fig,'PaperSize',[32 32]);

set(fig,'PaperPositionMode','manual');


%% ------------------------- Panel settings ------------------------------

nRows = 4;
nCols = 3;

ax = gobjects(nRows,nCols);


rowNames = { ...
    '$U_{FS}$', ...
    '$U_D$', ...
    '$C=-U_C$', ...
    '$R=U_R$' ...
    };


panelLab = { ...
    'a','b','c', ...
    'd','e','f', ...
    'g','h','i', ...
    'j','k','l' ...
    };


%% ---------------------- Manual compact layout --------------------------

left0     = 0.055;
colStep   = 0.305;
axW       = 0.265;

bottomTop = 0.765;
rowStep   = 0.225;
axH       = 0.195;


%% ----------------------------- Panels ----------------------------------

for r = 1:nRows

    for j = 1:nCols


        left   = left0 + (j-1)*colStep;

        bottom = bottomTop - (r-1)*rowStep;


        ax(r,j) = axes( ...
            'Parent',fig, ...
            'Position',[left bottom axW axH] ...
            );


        hold(ax(r,j),'on');

        axis(ax(r,j),'equal');

        axis(ax(r,j),'off');


        %% ---------------- Select plotted field --------------------------

        switch r

            case 1

                Z = D(j).UFS / Uref;

            case 2

                Z = D(j).UD / Uref;

            case 3

                Z = D(j).C / Uref;

            case 4

                Z = D(j).R / Uref;

        end


        %% ------------------- Plot filled field --------------------------

        surf( ...
            ax(r,j), ...
            D(j).X, ...
            D(j).Yc, ...
            zeros(size(Z)), ...
            Z, ...
            'EdgeColor','none' ...
            );


        view(ax(r,j),2);


        %% ------------------- Full pipe outline --------------------------

        th = linspace(0,2*pi,600);


        plot( ...
            ax(r,j), ...
            cos(th), ...
            sin(th), ...
            'k', ...
            'LineWidth',1.2 ...
            );


        %% ------------------- Free-surface line --------------------------

        yfs = -cos(D(j).alpha);

        xx = sqrt(max(0,1-yfs^2));


        plot( ...
            ax(r,j), ...
            [-xx xx], ...
            [yfs yfs], ...
            '--', ...
            'Color',[0.25 0.25 0.25], ...
            'LineWidth',1 ...
            );


        %% -------------------- Axes limits -------------------------------

        xlim(ax(r,j),[-1.06 1.06]);

        ylim(ax(r,j),[-1.06 1.06]);

        caxis(ax(r,j),[0 allMax]);


        %% -------------------- Panel labels ------------------------------

        p = (r-1)*nCols + j;


        text( ...
            ax(r,j), ...
            0.03,0.96, ...
            panelLab{p}, ...
            'Units','normalized', ...
            'FontWeight','bold', ...
            'FontSize',23, ...
            'VerticalAlignment','top' ...
            );


        %% ---------------- Column headings -------------------------------

        if r == 1


            text( ...
                ax(r,j), ...
                1.00,0.96, ...
                sprintf('$H=%.2f$',Hs(j)), ...
                'Units','normalized', ...
                'Interpreter','latex', ...
                'HorizontalAlignment','right', ...
                'VerticalAlignment','top', ...
                'FontSize',14 ...
                );


            text( ...
                ax(r,j), ...
                0.50,1.10, ...
                stateLab{j}, ...
                'Units','normalized', ...
                'HorizontalAlignment','center', ...
                'FontWeight','bold', ...
                'FontSize',23, ...
                'Clipping','off' ...
                );


        end


        %% ---------------- Row headings ---------------------------------

        if j == 1


            text( ...
                ax(r,j), ...
                -0.12,0.50, ...
                rowNames{r}, ...
                'Units','normalized', ...
                'Interpreter','latex', ...
                'Rotation',90, ...
                'HorizontalAlignment','center', ...
                'VerticalAlignment','middle', ...
                'FontSize',15, ...
                'Clipping','off' ...
                );


        end


    end

end


%% -------------------- R2019b turbo colormap ----------------------------

cmap = turboR2019b(256);

colormap(fig,cmap);


%% --------------------------- Colorbar ----------------------------------

cb = colorbar(ax(2,3));

cb.Units = 'normalized';

cb.Position = [0.90 0.165 0.012 0.68];

cb.FontSize = 10;


cb.Label.Interpreter = 'latex';

cb.Label.String = '$U/U_{ref}$';

cb.Label.FontSize = 14;


%% ============================= EXPORT =================================

% MATLAB R2019b does not support exportgraphics().
% Use print() instead.


%% ----------------------------- PNG -------------------------------------

set(fig,'Renderer','opengl');


print( ...
    fig, ...
    'Fig3_boundary_mechanism_fields_updated.png', ...
    '-dpng', ...
    '-r600' ...
    );


fprintf('Uref = %.6g\n',Uref);

fprintf('Saved: Fig3_boundary_mechanism_fields_updated.png\n');


%% ---------------- Optional PDF -----------------------------------------

% Uncomment if PDF output is required.
%
% For vector-style PDF, painters renderer is preferable.
%
% set(fig,'Renderer','painters');
%
% print( ...
%     fig, ...
%     'Fig3_boundary_mechanism_fields_updated.pdf', ...
%     '-dpdf', ...
%     '-painters' ...
%     );
%
% fprintf('Saved: Fig3_boundary_mechanism_fields_updated.pdf\n');



%% ======================================================================
% LOCAL FUNCTION: Exact DCR field
% =======================================================================

function D = dcrField(H,ns,nxi,nk,xiMax,kMax)


%% ---------------- Filling-angle parameter ------------------------------

a = acos(1-H);


%% ---------------- Computational coordinates ----------------------------

xi = linspace(-xiMax,xiMax,nxi);

s = linspace(0,1,ns);


[XI,S] = meshgrid(xi,s);


%% ---------------- Coordinate transformation ---------------------------

den = cosh(XI) + cos(a*S);


X = sin(a) .* sinh(XI) ./ den;


Y = -sin(a) .* sin(a*S) ./ den;


Yc = Y - cos(a);


%% ----------------------- Driving field ---------------------------------

UD = ...
    sin(a) .* sin(a*(1-S)) ...
    ./ (2*den);


%% ---------------- Fourier integration ----------------------------------

k = linspace(1e-4,kMax,nk);


dk = k(2)-k(1);


% Trapezoidal quadrature weights

w = ones(size(k));

w([1 end]) = 0.5;

w = w*dk;


%% ---------------- Initialize fields ------------------------------------

UC = zeros(size(XI));

chiN = zeros(size(XI));


%% ---------------- Numerical integration -------------------------------

for q = 1:nk


    kk = k(q);


    ck = cos(kk*xi);


    sh = sinh(kk*a*(1-s)).';


    shape = sh * ck;


    %% Confinement contribution

    UC = UC ...
        - w(q) ...
        * sin(a)^2 ...
        * ( ...
        kk ...
        / (sinh(pi*kk)*sinh(a*kk)) ...
        ) ...
        * shape;


    %% Auxiliary normal field

    chiN = chiN ...
        - w(q) ...
        * (sin(2*a)/2) ...
        * ( ...
        1 ...
        / (sinh(pi*kk)*cosh(a*kk)) ...
        ) ...
        * shape;


end


%% ------------------- Release contribution ------------------------------

UR = chiN - UC;


%% ---------------- Physical free-surface field --------------------------

UFS = UD + UC + UR;


%% ---------------- Positive magnitudes ----------------------------------

C = -UC;

R = UR;


%% --------------------------- Output ------------------------------------

D = struct( ...
    'H',H, ...
    'alpha',a, ...
    'X',X, ...
    'Yc',Yc, ...
    'UD',UD, ...
    'UC',UC, ...
    'R',R, ...
    'C',C, ...
    'UFS',UFS ...
    );


end



%% ======================================================================
% TURBO COLORMAP FOR MATLAB R2019b
% =======================================================================
%
% Backward-compatible approximation of the Turbo colormap.
%
% MATLAB R2019b does not include the built-in turbo() function.
%
% Usage:
%
%       cmap = turboR2019b(256);
%
% =======================================================================

function cmap = turboR2019b(n)


if nargin < 1

    n = 256;

end


%% ---------------- Normalized coordinate --------------------------------

x = linspace(0,1,n)';


x2 = x.^2;

x3 = x.^3;

x4 = x.^4;

x5 = x.^5;


%% ---------------- Turbo polynomial coefficients ------------------------

kRed = [ ...
     0.13572138 ...
     4.61539260 ...
   -42.66032258 ...
   132.13108234 ...
  -152.94239396 ...
    59.28637943 ...
    ];


kGreen = [ ...
     0.09140261 ...
     2.19418839 ...
     4.84296658 ...
   -14.18503333 ...
     4.27729857 ...
     2.82956604 ...
    ];


kBlue = [ ...
      0.10667330 ...
     12.64194608 ...
    -60.58204836 ...
    110.36276771 ...
    -89.90310912 ...
     27.34824973 ...
    ];


%% ---------------- Polynomial basis -------------------------------------

X = [ ...
    ones(n,1) ...
    x ...
    x2 ...
    x3 ...
    x4 ...
    x5 ...
    ];


%% ---------------- Calculate RGB ----------------------------------------

red   = X*kRed';

green = X*kGreen';

blue  = X*kBlue';


cmap = [red green blue];


%% ---------------- Clamp to valid RGB range -----------------------------

cmap(cmap < 0) = 0;

cmap(cmap > 1) = 1;


end