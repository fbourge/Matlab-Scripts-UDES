function [ stop, grid3D_REF_global_vect,  grid3D_TEST_vect, sommeZ_TEST_vect, sommeZ_REF_vect] = CompareFrame_Voxel_Voxel( grid3D_REF, grid3D_TEST, size_voxel,onlyNoData,nameOutput)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

m_4D = ndims(grid3D_REF)==4;

total_size_REF = size(grid3D_REF,1)*size(grid3D_REF,2)*size(grid3D_REF,3);
total_size_TEST = size(grid3D_TEST,1)*size(grid3D_TEST,2)*size(grid3D_TEST,3);

if(total_size_REF~=total_size_TEST)
    stop = 1;
    %exit();
else
    total_size = total_size_REF;
end

if(m_4D)
    grid3D_REF_global = grid3D_REF(:,:,:,1) + grid3D_REF(:,:,:,2);
else
    grid3D_REF_global = grid3D_REF;
end

% %% Delete all == 0 data in reference // option to pay attention
% grid3D_REF_global(grid3D_TEST==0)=0;





%% FORMATAGE

% 3D
%grid3D_REF_global_mask = grid3D_REF_global;%.*grid3D_binar;

grid3D_REF_global_vect = reshape(grid3D_REF_global,1, total_size);
%grid3D_REF_global_mask_vect = reshape(grid3D_REF_global_mask,1, total_size);
grid3D_TEST_vect = reshape(grid3D_TEST,1, total_size);


% 2D
dimY = size(grid3D_TEST,2);
sommeXZ_TEST = sum(grid3D_TEST,2);
sommeXZ_REF = sum(grid3D_REF_global,2);


sommeXZ_TEST_vect = reshape(sommeXZ_TEST,1,size(sommeXZ_TEST,1)*size(sommeXZ_TEST,2)*size(sommeXZ_TEST,3));
sommeXZ_REF_vect = reshape(sommeXZ_REF,1,size(sommeXZ_REF,1)*size(sommeXZ_REF,2)*size(sommeXZ_REF,3));




% 1D Z profile
dimX = size(grid3D_TEST,1);
sommeZ_TEST = sum(sommeXZ_TEST,1);
sommeZ_REF = sum(sommeXZ_REF,1);


sommeZ_TEST_vect = reshape(sommeZ_TEST,1,size(sommeZ_TEST,1)*size(sommeZ_TEST,2)*size(sommeZ_TEST,3));
sommeZ_REF_vect = reshape(sommeZ_REF,1,size(sommeZ_REF,1)*size(sommeZ_REF,2)*size(sommeZ_REF,3));





if(onlyNoData)

grid3D_REF_global_vect(grid3D_TEST_vect==0)=[];
grid3D_TEST_vect(grid3D_TEST_vect==0)=[];

numel(grid3D_REF_global_vect)
numel(grid3D_TEST_vect)

sommeXZ_REF_vect(sommeXZ_TEST_vect==0)=[];
sommeXZ_TEST_vect(sommeXZ_TEST_vect==0)=[];

numel(sommeXZ_TEST_vect)
numel(sommeXZ_REF_vect)
    
sommeZ_REF_vect(sommeZ_TEST_vect==0)=[];
sommeZ_TEST_vect(sommeZ_TEST_vect==0)=[];

numel(sommeZ_TEST_vect)
numel(sommeZ_REF_vect)

% -- Normalisation
sommeXZ_TEST_vect = sommeXZ_TEST_vect./dimY; 
sommeXZ_REF_vect = sommeXZ_REF_vect./dimY; 
% -- Normalisation
sommeZ_TEST_vect = sommeZ_TEST_vect./(dimX*dimY); 
sommeZ_REF_vect = sommeZ_REF_vect./(dimX*dimY); 

else
% -- Normalisation
sommeXZ_TEST_vect = sommeXZ_TEST_vect./dimY; 
sommeXZ_REF_vect = sommeXZ_REF_vect./dimY; 
% -- Normalisation
sommeZ_TEST_vect = sommeZ_TEST_vect./(dimX*dimY); 
sommeZ_REF_vect = sommeZ_REF_vect./(dimX*dimY); 
end

% Linear Regression
mdl_3D = LinearModel.fit(grid3D_TEST_vect, grid3D_REF_global_vect );
mdl_XZ = LinearModel.fit(sommeXZ_TEST_vect, sommeXZ_REF_vect);
mdl_Z = LinearModel.fit(sommeZ_TEST_vect, sommeZ_REF_vect);


%% PLOT

hFig = figure(1);
set(hFig, 'Position', [1920 0 1300 700]);

  
subaxis(2,3,1,'SpacingHoriz', 0.04, 'SpacingVert',0.05, 'PL',0.04,'PR',0,'PT',0.05,'PB',0, ...
    'mt', 0,'mb',0,'ML',0,'MR',0); hold on;
minmaxplot3D = [minmax(grid3D_TEST_vect) 0 10];
cloudPlot(grid3D_TEST_vect,grid3D_REF_global_vect,minmaxplot3D, [10 10]);
plot( grid3D_TEST_vect, mdl_3D.Fitted,'R');
xlabel('IDR, LVOX (sans unit\''e)','Interpreter','Latex','FontSize',16);
ylabel('LARCHI $m^{2}/m^{3}$','Interpreter','Latex','FontSize',16);
title('3D','Interpreter','Latex','FontSize',16);


subaxis(2,3,2,'SpacingHoriz', 0.04, 'SpacingVert',0.05, 'PL',0.03,'PR',0.01,'PT',0.05,'PB',0, ...
    'mt', 0,'mb',0,'ML',0,'MR',0); hold on;
minmaxplotXZ = [minmax(sommeXZ_TEST_vect) 0 0.6];
cloudPlot(sommeXZ_TEST_vect,sommeXZ_REF_vect,minmaxplotXZ, [10 10]);
plot( sommeXZ_TEST_vect, mdl_XZ.Fitted,'R');
xlabel('IDR, LVOX (sans unit\''e)','Interpreter','Latex','FontSize',16);
ylabel('LARCHI $m^{2}/m^{3}$','Interpreter','Latex','FontSize',16);
title('2D (XZ)','Interpreter','Latex','FontSize',16);


subaxis(2,3,3,'SpacingHoriz', 0.04, 'SpacingVert',0.05, 'PL',0.02,'PR',0.02,'PT',0.05,'PB',0, ...
    'mt', 0,'mb',0,'ML',0,'MR',0); hold on;
minmaxplotZ = [minmax(sommeZ_TEST_vect) minmax(sommeZ_REF_vect)];
%cloudPlot(sommeZ_TEST_vect,sommeZ_REF_vect,minmaxplotZ, [100 100]);
plot(sommeZ_TEST_vect,sommeZ_REF_vect,'.');
plot( sommeZ_TEST_vect,mdl_Z.Fitted,'R');
xlabel('IDR, LVOX (sans unit\''e)','Interpreter','Latex','FontSize',16);
ylabel('LARCHI $m^{2}/m^{3}$','Interpreter','Latex','FontSize',16);
title('1D (profil Z)','Interpreter','Latex','FontSize',16);


obs1 = sprintf('Number of observations: %i', mdl_3D.NumObservations); 
errf1 = sprintf('Degrees of freedom: %0.3f ', mdl_3D.NumEstimatedCoefficients); 
rmse1 = sprintf('RMSE: %0.3f ', mdl_3D.RMSE ); 
r21 = sprintf('$R^{2}$:  %0.3f', mdl_3D.Rsquared.Ordinary); 
pente1 = sprintf('Droite: Y = %0.3f*X + %0.3f', mdl_3D.Coefficients.Estimate(2),mdl_3D.Coefficients.Estimate(1)); 

ax = subaxis(2,3,4,'SpacingHoriz', 0.04, 'SpacingVert',0.08, 'PL',0.04,'PR',0,'PT',0.08,'PB',0, ...
    'mt', 0,'mb',0,'ML',0,'MR',0); hold on;
text(0,1,r21,'Interpreter','Latex','FontSize',16);
text(0,0.85,rmse1 ,'Interpreter','Latex','FontSize',16);
text(0,0.70,pente1,'Interpreter','Latex','FontSize',16);
text(0,0.55,obs1,'Interpreter','Latex','FontSize',16);
set ( ax, 'visible', 'off');                                                                   


obs2 = sprintf('Number of observations: %i', mdl_XZ.NumObservations ); 
errf2 = sprintf('Degrees of freedom: %0.3f ', mdl_XZ.NumEstimatedCoefficients); 
rmse2 = sprintf('RMSE: %0.3f ', mdl_XZ.RMSE ); 
r22 = sprintf('$R^{2}$:  %0.3f', mdl_XZ.Rsquared.Ordinary ); 
pente2 = sprintf('Droite: Y = %0.3f*X + %0.3f', mdl_XZ.Coefficients.Estimate(2),mdl_XZ.Coefficients.Estimate(1)); 

ax = subaxis(2,3,5,'SpacingHoriz', 0.04, 'SpacingVert',0.08, 'PL',0.03,'PR',0.01,'PT',0.08,'PB',0, ...
    'mt', 0,'mb',0,'ML',0,'MR',0);
text(0,1,r22,'Interpreter','Latex','FontSize',16);
text(0,0.85,rmse2,'Interpreter','Latex','FontSize',16);
text(0,0.70,pente2,'Interpreter','Latex','FontSize',16);
text(0,0.55,obs2,'Interpreter','Latex','FontSize',16);
set ( ax, 'visible', 'off');  mdl_Z = LinearModel.fit(sommeZ_TEST_vect, sommeZ_REF_vect );


obs3 = sprintf('Number of observations: %i', mdl_Z.NumObservations ); 
errf3 = sprintf('Degrees of freedom: %0.3f ', mdl_Z.NumEstimatedCoefficients); 
rmse3 = sprintf('RMSE: %0.3f ', mdl_Z.RMSE ); 
r23 = sprintf('$R^{2}$:  %0.3f', mdl_Z.Rsquared.Ordinary); 
pente3 = sprintf('Droite: Y = %0.3f*X + %0.3f', mdl_Z.Coefficients.Estimate(2),mdl_Z.Coefficients.Estimate(1)); 

ax = subaxis(2,3,6,'SpacingHoriz', 0.04, 'SpacingVert',0.08, 'PL',0.02,'PR',0.02,'PT',0.08,'PB',0, ...
    'mt', 0,'mb',0,'ML',0,'MR',0);
text(0,1,r23,'Interpreter','Latex','FontSize',16);
text(0,0.85,rmse3,'Interpreter','Latex','FontSize',16);
text(0,0.70,pente3,'Interpreter','Latex','FontSize',16);
text(0,0.55,obs3,'Interpreter','Latex','FontSize',16);
set ( ax, 'visible', 'off'); 

pathfig = strcat('/home/florentin/Google Drive/UDES/Cours/',nameOutput,'.fig');
patheps = strcat('/home/florentin/Google Drive/UDES/Cours/',nameOutput,'.eps');
pathpdf = strcat('/home/florentin/Google Drive/UDES/Cours/',nameOutput,'.pdf');
pathpng = strcat('/home/florentin/Google Drive/UDES/Cours/',nameOutput,'.png');

%saveas(hFig,pathfig);
%export_fig ('-q101' ,'-a1','-transparent',pathpdf );
%export_fig ('-q101' ,'-a1','-transparent',pathpng );


stop = 0;

end

