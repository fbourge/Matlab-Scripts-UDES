function [A_sommeXZ_Lvox,B_sommeXZ_Lvox,A_sommeZ1_Lvox,B_sommeZ1_Lvox,scaleZ]=compare2SetOfGrids( placette, size_cm, reduction )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
num_erreur = 3;

%% Chargement des grilles Avant
load(strcat(placette,'_avant_',size_cm,'.mat'));
A_size_voxel = result{1};
A_grid3D_lvox_corrected = result{2};
A_grid3D_ = result{3};
A_grid3D_TOTAL_value = result{4};

[A_grid3D_TOTAL_value, A_bbox_minimal, A_bbox_coord_minimal, A_dim, A_m_4D ] = minimal3D_BBox( A_grid3D_TOTAL_value, [0,0,0], A_size_voxel );
[ A_sommeYZ_Hits_TOTAL, A_sommeXZ_Hits_TOTAL, A_sommeXY_Hits_TOTAL, A_sommeZ1_Hits_TOTAL, A_sommeZ2_Hits_TOTAL ] = profile_density_Hits( A_grid3D_TOTAL_value);


A_sommeZ1_Hits_TOTAL(1:7)=0;
dim = size(A_grid3D_);
A_grid3D_noData = zeros(dim(1), dim(2), dim(3), num_erreur);
A_grid3D_noData(A_grid3D_<0) = 1; 
% -------------------

%% Chargement des grilles Après
load(strcat(placette,'_apres_',size_cm),'-mat');
B_isTOTAL_hits = size(result,2)==6;
B_size_voxel = result{1};
B_grid3D_lvox_corrected = result{2};
B_grid3D_ = result{3};
B_grid3D_value = result{4};
if(B_isTOTAL_hits)
    B_grid3D_TOTAL_value = result{5};
end

[B_grid3D_value, B_bbox_minimal, B_bbox_coord_minimal, B_dim, B_m_4D ] = minimal3D_BBox( B_grid3D_value, [0,0,0], B_size_voxel );
[B_grid3D_, B_bbox_minimal, B_bbox_coord_minimal, B_dim, B_m_4D ] = minimal3D_BBox( B_grid3D_, [0,0,0], B_size_voxel );
dim = size(B_grid3D_);
B_grid3D_noData = zeros(dim(1), dim(2), dim(3), num_erreur);
B_grid3D_noData(A_grid3D_<0) = 1; 
% -------------------

 

 % Recadrage et calcul des grilles 
[A_grid3D_resized, A_bbox_minimal, A_bbox_coord_minimal, A_dim, A_m_4D ] = minimal3D_BBox( A_grid3D_lvox_corrected, [0,0,0], A_size_voxel );
[B_grid3D_resized, B_bbox_minimal, B_bbox_coord_minimal, B_dim, B_m_4D ] = minimal3D_BBox( B_grid3D_lvox_corrected, [0,0,0], B_size_voxel );

% Ecrasement des valeurs trop fortes
if(1)
A_grid3D_resized(A_grid3D_resized>10)=0;
B_grid3D_resized(B_grid3D_resized>20)=0;
end

% Calcul des pofils
[ A_sommeYZ_Lvox, A_sommeXZ_Lvox, A_sommeZ1_Lvox, A_sommeZ2_Lvox, A_sommeXY_Lvox ] = ...
     profile_density_LVOX( A_grid3D_resized, strcat(placette,'Avant'), A_size_voxel, 0 );
% 
 [ B_sommeYZ_Lvox, B_sommeXZ_Lvox, B_sommeZ1_Lvox, B_sommeZ2_Lvox, B_sommeXY_Lvox ] = ...
     profile_density_LVOX( B_grid3D_resized, strcat(placette,'Apres'), B_size_voxel, 0 );
 
%% Reduce dimension
if(reduction)
 [ A_sommeZ1_Lvox ] = reduce_dimension( A_sommeZ1_Lvox, A_size_voxel, 1 );
 [ B_sommeZ1_Lvox ] = reduce_dimension( B_sommeZ1_Lvox, A_size_voxel, 1 );
 [ A_sommeZ1_Hits_TOTAL ] = reduce_dimension( A_sommeZ1_Hits_TOTAL, A_size_voxel, 1 );
 A_size_voxel = 1;
end

size_cm = num2str(A_size_voxel);

%% Adjust profiles
% Ajustement de la grille de densité avant sur la grille de densite apres
[ offset , correlation, ratio, A_sommeZ1_Lvox,A_diff, B_diff] = AdjustProfiles(A_sommeZ1_Lvox,B_sommeZ1_Lvox);
% Ajustement de la grille de hits avant sur la grilles de densite avant
[ offset2 , correlation2, ratio2,A_sommeZ1_Hits_TOTAL,A2_diff, B2_diff] = AdjustProfiles(A_sommeZ1_Hits_TOTAL,A_sommeZ1_Lvox);


A_sommeXZ_Lvox=A_sommeXZ_Lvox';
B_sommeXZ_Lvox=B_sommeXZ_Lvox';

A_sommeXZ_Lvox = [A_sommeXZ_Lvox;zeros(A_diff,size(A_sommeXZ_Lvox,2))];
B_sommeXZ_Lvox = [B_sommeXZ_Lvox;zeros(B_diff,size(B_sommeXZ_Lvox,2))];




%% Linear Regression
x=A_sommeZ1_Lvox;
y=B_sommeZ1_Lvox;

b1=x\y; % régression linéaire de x par rapport à y
yCalc1 = b1*x;

X = [ones(length(x),1) x];
b = X\y; % régression linéaire de x par rapport à y avec interception (valeur de y quand x=0)
yCalc2 = X*b;


Rsq1 = 1 - sum((y - yCalc1).^2)/sum((y - mean(y)).^2)
Rsq2 = 1 - sum((y - yCalc2).^2)/sum((y - mean(y)).^2)



%% Trace

% plot_HitsvsPlantDensity( sommeZ1_Hits, A_sommeZ1_Lvox, B_size_voxel , strcat(placette,'_apres_',dimension), strcat(placette,'_apres_',dimension,'m'));

scaleZ = (A_size_voxel:A_size_voxel:size(A_sommeZ1_Lvox,1)*A_size_voxel)'; % nouvelle ï¿½chelle en mï¿½tres


% Create figure
figure1 = figure('Name',strcat(placette,'_apres_',size_cm),'NumberTitle','off', 'Position', [20 30 1350 780]);
colormap('pink');
% Create axes
% axes1 = axes('Parent',figure1,...
%     'Position',[0.13 0.11 0.15 0.7]);
% hold(axes1,'on');
sub1 = subplot_tight(2,4,[1,5],0.1);
imagesc(A_sommeXZ_Lvox,'Parent', sub1);
title('Avant','Parent', sub1);
axis('xy','image');
xlabel('X');
ylabel('Z');

sub2 = subplot_tight(2,4,[2,6],0.1);
imagesc(B_sommeXZ_Lvox,'Parent', sub2);
title('Après','Parent', sub2);
axis('xy','image');
xlabel('X');
ylabel('Z');



% subplot_tight Graphique
 sub3 = subplot_tight(2,4,[3,7],[0.1,0.05]);
%A_sommeZ1_Hits_TOTAL=[A_sommeZ1_Hits_TOTAL(3:end);zeros(3,1)];

l10 = line(A_sommeZ1_Hits_TOTAL(1:size(scaleZ,1)),scaleZ,'Color','k','LineWidth',0.8);
%l11 = line(hits_fitted,scaleZ,'Color','r','LineStyle','--','LineWidth',2);
ax1 = get(gca); % current axes


xlabel('$points/couche$','Interpreter','Latex','FontSize',16);
ylabel('Hauteur Z (m)','Interpreter','Latex','FontSize',16);

set(gca,'XColor','k');
set(gca,'YColor','k');
set(gca,'YGrid','on');
%set(gca,'LineWidth','2');

ax1_pos = ax1.Position; % position of first axes
ax2 = axes('Position',ax1_pos,...
    'XAxisLocation','top',...
    'YAxisLocation','right',...
    'Color','none');

l20 = line(A_sommeZ1_Lvox,scaleZ,'Parent',ax2,'Color','b','LineStyle','-','LineWidth',1.5);
l21 = line(B_sommeZ1_Lvox,scaleZ,'Parent',ax2,'Color','g','LineStyle','-','LineWidth',1.5);
legend([l10 l20 l21 ],'Retours_{avant}','PAD_{avant}','PAD_{apres}');
xlabel('$moy(PAD)/couche (m^{2}.m^{-3}.)$','Interpreter','Latex','FontSize',16);

set(gca,'XColor','b');
set(gca,'YColor','k');

%title(plotName,'Interpreter','Latex','FontSize',16);

%///////////////  Trace TEXT ///////////////

ax = subplot_tight(2, 4, 4,0.06);
if(size(placette,2)==2 & placette=='ee')
    placatteName = 'Placette : {\''Erable} / {\''Erable} ';
elseif(size(placette,2)==2 & placette=='se')
    placatteName = 'Placette : Sapin / {\''Erable}';
elseif(size(placette,2)==2 & placette=='es')
    placatteName = 'Placette : {\''Erable} / Sapin';
elseif(size(placette,2)==3 & placette=='ss1')
    placatteName = 'Placette : Sapin / Sapin I';
elseif(size(placette,2)==3 & placette=='ss2')
    placatteName = 'Placette : Sapin / Sapin II';
elseif(size(placette,2)==3 & placette=='ss3')
    placatteName = 'Placette : Sapin / Sapin III';
end
axis off
% Add title string
text('Parent',ax,'Interpreter','latex','FontSize',15,...
    'String',placatteName,...
    'Position',[0 1 0],...
    'Visible','on');


% Add dimension string
text('Parent',ax,'Interpreter','latex','FontSize',12,...
    'String',strcat('{R\''esolution} de la grille :{ }',size_cm,' m'),...
    'Position',[0 0.90 0],...
    'Visible','on');


% Add subtitle string
text('Parent',ax,'Interpreter','latex','FontSize',14,...
    'String',strcat('Comparaison IDR avant/apres'),...
    'Position',[0 0.75 0],...
    'Visible','on');

% Add overlapping rate string
text('Parent',ax,'Interpreter','latex','FontSize',12,...
    'String',strcat('Taux de recouvrement vertical :{ }', num2str(ratio*100,'% 0.2f '),'{\%}'),...
    'Position',[0 0.65 0],...
    'Visible','on');

% Add correlation coefficient string 
text('Parent',ax,'Interpreter','latex','FontSize',12,...
    'String',strcat('Coefficient de {corr\''elation lin\''eaire} :{ }',num2str(correlation,'% 0.3f')),...
    'Position',[0 0.55 0],...
    'Visible','on');

%Add offset string
text('Parent',ax,'Interpreter','latex','FontSize',12,...
    'String',strcat('Offset :{ }',num2str(offset)),...
    'Position',[0 0.45 0],...
    'Visible','on');

%Add linear correlation  string
text('Parent',ax,'Interpreter','latex','FontSize',12,...
    'String',{  strcat('{R\''egression lin\''eaire} a.x + b :{ }'), ...
                strcat('a ={ }',num2str(b(2),3), '{ }; b ={ }',num2str(b(1),3)), ...
                strcat('$R^{2}$ = {}',num2str(Rsq2,3))},...
    'Position',[0 0.1 0],...
    'Visible','on');



% Linear regression
sub5 = subplot_tight(2,4,8,[0.2,0.08]);
plot(x,x, 'LineStyle',':','LineWidth',1,'Color',[0.8 0.8 0.8],'Parent', sub5);
hold on
scatter(x,y, '.','Parent', sub5);
plot(x,yCalc1,'Parent', sub5)
grid on
plot(x,yCalc2,'--','Parent', sub5)


legend('Ref 1:1','Data','a.x','a.x + b','Location','best');
xlabel('Profil avant (PAD)');
ylabel('Profil apres (PAD)');

saveas(figure1,strcat(placette,size_cm,'cm.tiff'));

end

