%% Fig4_boundary_competition_results.m
% Boundary subsystem: C_Q versus R_Q, normalized state variables, and the
% universal semicircle. Uses exact scalar discharge formulas.
clear; clc; close all;
set(groot,'defaultAxesFontName','Arial','defaultTextFontName','Arial','defaultAxesFontSize',12);
H=linspace(0.01,1.99,260); n=numel(H);
CQ=zeros(1,n); RQ=CQ; SB=CQ; betaB=CQ; mB=CQ;
for i=1:n
    d=dcrScalar(H(i)); CQ(i)=d.CQ; RQ(i)=d.RQ; SB(i)=d.SB; betaB(i)=d.betaB; mB(i)=d.mB;
end
fprintf('max |beta_B^2+m_B^2-1| = %.3e\n',max(abs(betaB.^2+mB.^2-1)));
Hs=[0.30 1.00 1.80]; stateLab={'I','II','III'}; b3=zeros(size(Hs)); m3=b3;
for j=1:3, d=dcrScalar(Hs(j)); b3(j)=d.betaB; m3(j)=d.mB; end
fig=figure('Color','w','Units','centimeters','Position',[1 1 32 12.5]);

ax1=axes(fig,'Position',[0.07 0.18 0.27 0.70]); hold(ax1,'on'); box(ax1,'on');
plot(ax1,H,CQ,'-b','LineWidth',1.5); plot(ax1,H,RQ,'--r','LineWidth',2.5); plot(ax1,H,SB,'k-.','LineWidth',3.5); yline(ax1,0,'k:'); xline(ax1,1,':');
xlabel(ax1,'$H$','Interpreter','latex','FontSize',15); ylabel(ax1,'Integrated boundary contribution','FontSize',15);
legend(ax1,{'$C_Q$','$R_Q$','$S_B=R_Q-C_Q$'},'Interpreter','latex','Location','NW','Box','off','FontSize',15);
text(ax1,-0.18,1.04,'a','Units','normalized','FontWeight','bold','FontSize',23,'Clipping','off');

ax2=axes(fig,'Position',[0.395 0.18 0.25 0.70]); hold(ax2,'on'); box(ax2,'on');
plot(ax2,H,betaB,'-b','LineWidth',1.5); plot(ax2,H,mB,'--r','LineWidth',2.5); yline(ax2,0,'k:'); xline(ax2,1,':');
xlabel(ax2,'$H$','Interpreter','latex','FontSize',15); ylabel(ax2,'Normalized state','FontSize',15); ylim(ax2,[-1.02 1.05]);
legend(ax2,{'$\beta_B$','$m_B$'},'Interpreter','latex','Location','SE','Box','off','FontSize',15);
text(ax2,-0.12,1.04,'b','Units','normalized','FontWeight','bold','FontSize',23,'Clipping','off');

ax3=axes(fig,'Position',[0.72 0.18 0.235 0.70]); hold(ax3,'on'); box(ax3,'on'); axis(ax3,'equal');
b=linspace(-1,1,600); plot(ax3,b,sqrt(max(0,1-b.^2)),'Color',[0.70 0.70 0.70],'LineWidth',2.5);
plot(ax3,betaB,mB,'LineWidth',2.8);
mk={'o','s','^'};
for j=1:3
    plot(ax3,b3(j),m3(j),mk{j},'MarkerSize',10,'MarkerFaceColor','w','MarkerEdgeColor','k','LineWidth',1.4);
    text(ax3,b3(j)+0.05,m3(j)+0.035,stateLab{j},'FontWeight','bold','FontSize',15);
end
xline(ax3,0,':','Color',[0.55 0.55 0.55]); xlabel(ax3,'$\beta_B$','Interpreter','latex','FontSize',15); ylabel(ax3,'$m_B$','Interpreter','latex','FontSize',15);
xlim(ax3,[-1.02 1.02]); ylim(ax3,[0 1.05]); text(ax3,-0.15,1.04,'c','Units','normalized','FontWeight','bold','FontSize',23,'Clipping','off');
text(ax3,0.50,0.70,'balanced active','Units','normalized','HorizontalAlignment','center','FontSize',15);

% exportgraphics(fig,'Fig4_boundary_competition_results.pdf','ContentType','vector');

function d=dcrScalar(H)
a=acos(1-H);
ID=integral(@(k)fID(k,a),0,12,'RelTol',1e-8,'AbsTol',1e-11);
IN=integral(@(k)fIN(k,a),0,12,'RelTol',1e-8,'AbsTol',1e-11);
QD=a/8-sin(2*a)/12+sin(4*a)/96;
Qseg=cot(a)/6+a/(8*sin(a)^4)-cos(a)*(5-2*cos(a)^2)/(24*sin(a)^3)-pi*ID;
QRL=sin(a)^4*Qseg; QC=QRL-QD;
QFS=(a-sin(2*a)+0.25*sin(4*a)+2*pi*sin(2*a)^2*IN)/8;
QR=QFS-QRL; CQ=-QC; RQ=QR; NB=CQ+RQ; SB=RQ-CQ; MB=2*sqrt(max(0,CQ*RQ));
betaB=SB/NB; mB=MB/NB;
d=struct('QD',QD,'QRL',QRL,'QC',QC,'QFS',QFS,'QR',QR,'CQ',CQ,'RQ',RQ,'SB',SB,'betaB',betaB,'mB',mB);
end
function y=fID(k,a)
y=zeros(size(k)); z=k<1e-6; y(z)=1/(a*pi^2); kz=k(~z); y(~z)=kz.^3./(tanh(a*kz).*sinh(pi*kz).^2);
end
function y=fIN(k,a)
y=zeros(size(k)); z=k<1e-6; y(z)=a/pi^2; kz=k(~z); y(~z)=kz.*tanh(a*kz)./sinh(pi*kz).^2;
end
