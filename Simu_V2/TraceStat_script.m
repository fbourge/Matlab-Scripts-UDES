%% Trace Stat



RMSE = [];
Radj = [];
Corr2 = [];

for i=1:nbr_tranches

mdl_XY = LinearModel.fit(tranches{1,i}.XY_LVOX , tranches{1,i}.XY_LARCHI)
mdl_XZ = LinearModel.fit(tranches{1,i}.XZ_LVOX, tranches{1,i}.XZ_LARCHI);
mdl_YZ = LinearModel.fit(tranches{1,i}.YZ_LVOX, tranches{1,i}.YZ_LARCHI);
mdl_Z = LinearModel.fit(tranches{1,i}.Z_LVOX, tranches{1,i}.Z_LARCHI);



figure(i)
subplot(2,2,1);
corr2_XY = corr2(tranches{1,i}.XY_LVOX, tranches{1,i}.XY_LARCHI) ;
titleXY = sprintf('XY PROJECTION . RMSE = %0.3f ; Adj R^2 = %0.3f ; Correlation 2D = %0.3f  ', mdl_XY.RMSE, mdl_XY.Rsquared.Adjusted, corr2_XY ); 
title(titleXY); xlabel('Binarised hit data (cumulative density)'); ylabel('Reference data (cumulative density)'); 
hold on;
plot(tranches{1,i}.XY_LVOX, tranches{1,i}.XY_LARCHI,'.');
plot(tranches{1,i}.XY_LVOX, mdl_XY.Fitted, 'r');
%legend(sprintf('Data (%d observations)',mdl_XY.NumObservations),sprintf('y = %0.3fx + %0.3f',double(mdl_XY.Coefficients(2,1)),double(mdl_XY.Coefficients(1,1))));

subplot(2,2,2);
corr2_XZ = corr2(tranches{1,i}.XZ_LVOX, tranches{1,i}.XZ_LARCHI);
titleXZ = sprintf('XZ PROJECTION . RMSE = %0.3f ; Adj R^2  = %0.3f ; Correlation 2D = %0.3f ', mdl_XZ.RMSE, mdl_XZ.Rsquared.Adjusted, corr2_XZ ); 
title(titleXZ);
hold on;
scatter(tranches{1,i}.XZ_LVOX, tranches{1,i}.XZ_LARCHI,'.');
plot(tranches{1,i}.XZ_LVOX, mdl_XZ.Fitted, 'r');
%legend(sprintf('Data (%d observations)',mdl_XZ.NumObservations),sprintf('y = %0.3fx + %0.3f',double(mdl_XZ.Coefficients(2,1)),double(mdl_XZ.Coefficients(1,1))));

subplot(2,2,3);
corr2_YZ = corr2(tranches{1,i}.YZ_LVOX, tranches{1,i}.YZ_LARCHI);
titleYZ = sprintf('YZ PROJECTION . RMSE = %0.3f ; Adj R^2 = %0.3f ; Correlation 2D = %0.3f ', mdl_YZ.RMSE, mdl_YZ.Rsquared.Adjusted, corr2_YZ  ); 
title(titleYZ);
hold on;
scatter(tranches{1,i}.YZ_LVOX, tranches{1,i}.YZ_LARCHI,'.');
plot(tranches{1,i}.YZ_LVOX, mdl_YZ.Fitted, 'r');
%legend(sprintf('Data (%d observations)',mdl_YZ.NumObservations),sprintf('y = %0.3fx + %0.3f',double(mdl_YZ.Coefficients(2,1)),double(mdl_YZ.Coefficients(1,1))));

subplot(2,2,4);
corr2_Z = corr2(tranches{1,i}.Z_LVOX, tranches{1,i}.Z_LARCHI);
titleZ = sprintf('Z PROFILE . RMSE = %0.3f ; Adj R^2 = %0.3f ; Correlation 2D = %0.3f ', mdl_Z.RMSE, mdl_Z.Rsquared.Adjusted, corr2_Z ); 
title(titleZ);
hold on;
scatter(tranches{1,i}.Z_LVOX, tranches{1,i}.Z_LARCHI,'.');
plot(tranches{1,i}.Z_LVOX, mdl_Z.Fitted, 'r');
%legend(sprintf('Data (%d observations)',mdl_Z.NumObservations),sprintf('y = %0.3fx + %0.3f',double(mdl_Z.Coefficients(2,1)),double(mdl_Z.Coefficients(1,1))));



RMSE = [RMSE;mdl_XY.RMSE mdl_XZ.RMSE mdl_YZ.RMSE mdl_Z.RMSE];
Radj = [Radj;mdl_XY.Rsquared.Adjusted mdl_XZ.Rsquared.Adjusted mdl_YZ.Rsquared.Adjusted mdl_Z.Rsquared.Adjusted];
Corr2 = [Corr2; corr2_XY corr2_XZ corr2_YZ corr2_Z];



end




% figure(i+1);
% plot(scaleZ,RMSE);title('Evolution du RMSE par couche selon Z');legend('XY','XZ','YZ','Z');xlabel('Z (m)');ylabel('RMSE');
% figure(i+2);
% plot(scaleZ,Radj);title('Evolution du R^2 Adj par couche selon Z');legend('XY','XZ','YZ','Z');xlabel('Z (m)');ylabel('R^2 Adj');
% figure(i+3);
% plot(scaleZ,Radj);title('Evolution du Corr2 par couche selon Z');legend('XY','XZ','YZ','Z');xlabel('Z (m)');ylabel('Corr2');
