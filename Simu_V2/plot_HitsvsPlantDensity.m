function plot_HitsvsPlantDensity( hits, LARCHI_density, size_voxel , plotName, nameOutput)
%function plot_HitsvsPlantDensity( grid3D_value, grid3D_rescaled, size_voxel , plotName, nameOutput)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

% hits : pourcentage de retours d'une couche horizontale sur la totalité de la grille
% LARCHI_density : moyenne de PAD/voxel/couche



%[ stop, grid3D_REF_global_vect,  grid3D_TEST_vect, hits, LARCHI_density] = CompareFrame( grid3D_rescaled, grid3D_value, size_voxel, nameOutput);

if(size(LARCHI_density,2)==2)
LARCHI_density=LARCHI_density(:,1)+LARCHI_density(:,2);
end


scaleZ = (size_voxel:size_voxel:size(hits,1)*size_voxel)'; % nouvelle échelle en mètres


%%Fitting Weibull
Weibull_modelfun = @(b,x)b(3)*((b(1)/b(2)).*((x/b(2)).^(b(1)-1)).*exp(-(x/b(2)).^b(1)));
b0 = [1;1;1];

mdl_hits = NonLinearModel.fit(scaleZ,hits,Weibull_modelfun,b0);
hits_fitted=mdl_hits.Fitted;
[C,I] = max(hits_fitted);
pt_max_hits = [C,I];

mdl_larchi = NonLinearModel.fit(scaleZ,LARCHI_density,Weibull_modelfun,b0);
LARCHI_density_fitted = mdl_larchi.Fitted;
[C,I] = max(LARCHI_density_fitted);
pt_max_larchi = [C,I];


%% Trace
hFig = figure('Name','YOUPI','NumberTitle','off', 'Position', [50 50 1100 500]);

% subplot_tight Graphique
subplot_tight(1,2,1,0.1);
l10 = line(hits,scaleZ,'Color','r','LineWidth',0.8);
l11 = line(hits_fitted,scaleZ,'Color','r','LineStyle','--','LineWidth',2);
ax1 = get(gca); % current axes


xlabel('$points.couche^{-1}$ (\%)','Interpreter','Latex','FontSize',16);
ylabel('Hauteur Z (m)','Interpreter','Latex','FontSize',16);

set(gca,'XColor','r');
set(gca,'YColor','k');
set(gca,'YGrid','on');
%set(gca,'LineWidth','2');

ax1_pos = ax1.Position; % position of first axes
ax2 = axes('Position',ax1_pos,...
    'XAxisLocation','top',...
    'YAxisLocation','right',...
    'Color','none');

l20 = line(LARCHI_density,scaleZ,'Parent',ax2,'Color','b','LineWidth',0.8);
l21 = line(LARCHI_density_fitted,scaleZ,'Parent',ax2,'Color','b','LineStyle','--','LineWidth',2);
legend([l20 l21 l10 l11],'L-ARCHITECT','L-ARCHITECT (weibull ajust�e)','Retours lidar-t','Retours lidar-t (weibull ajust�e)');
xlabel('$moy(PAD).couche^{-1}$  ($m^{2}/m^{3}$)','Interpreter','Latex','FontSize',16);

set(gca,'XColor','b');
set(gca,'YColor','k');

%title(plotName,'Interpreter','Latex','FontSize',16);


% subplot_tight details
ax = subplot_tight(1,2,2,0);

% /////// HITS ///////
weibull1 = sprintf('Weibull param : k = %0.3f, lambda = %0.3f, C = %0.3f', ...
                        mdl_hits.Coefficients.Estimate(1),mdl_hits.Coefficients.Estimate(2),mdl_hits.Coefficients.Estimate(3)); 
obs1 = sprintf('Number of observations: %i', mdl_hits.NumObservations); 
r21 = sprintf('$R^{2}$:  %0.3f', mdl_hits.Rsquared.Ordinary); 
rmse1 = sprintf('RMSE: %0.3f ', mdl_hits.RMSE ); 
pt1 = sprintf('Max hits =  %0.3f; Z max = %0.1f m ;',pt_max_hits(1),pt_max_hits(2)*size_voxel);

fix1 = 1;
text(0,fix1,'HITS','Interpreter','Latex','FontSize',16);
text(0,fix1-0.10,weibull1,'Interpreter','Latex','FontSize',16);
text(0,fix1-0.15,r21,'Interpreter','Latex','FontSize',16);
text(0,fix1-0.20,rmse1 ,'Interpreter','Latex','FontSize',16);
text(0,fix1-0.25,obs1,'Interpreter','Latex','FontSize',16);
text(0,fix1-0.30,pt1,'Interpreter','Latex','FontSize',16);

% /////// LARCHI ///////
weibull2 = sprintf('Weibull param : k = %0.3f, lambda = %0.3f, C = %0.3f', ...
                        mdl_larchi.Coefficients.Estimate(1),mdl_larchi.Coefficients.Estimate(2),mdl_larchi.Coefficients.Estimate(3)); 
obs2 = sprintf('Number of observations: %i', mdl_larchi.NumObservations); 
r22 = sprintf('$R^{2}$:  %0.3f', mdl_larchi.Rsquared.Ordinary); 
rmse2 = sprintf('RMSE: %0.3f ', mdl_larchi.RMSE ); 
pt2 = sprintf('Max hits =  %0.3f; Z max = %0.1f m ;',pt_max_larchi(1),pt_max_larchi(2)*size_voxel);

fix2 = fix1-0.5;
text(0,fix2,'LARCHI','Interpreter','Latex','FontSize',16);
text(0,fix2-0.10,weibull2,'Interpreter','Latex','FontSize',16);
text(0,fix2-0.15,r22,'Interpreter','Latex','FontSize',16);
text(0,fix2-0.20,rmse2 ,'Interpreter','Latex','FontSize',16);
text(0,fix2-0.25,obs2,'Interpreter','Latex','FontSize',16);
text(0,fix2-0.30,pt2,'Interpreter','Latex','FontSize',16);

set ( ax, 'visible', 'off'); 

% Save
pathfig = strcat('/home/florentin/Dropbox/',nameOutput,'.fig');
pathpdf = strcat('/home/florentin/Dropbox/',nameOutput,'.pdf');

%saveas(hFig,pathfig);
%export_fig ('-q101' ,'-a1','-transparent',pathpdf );

end

