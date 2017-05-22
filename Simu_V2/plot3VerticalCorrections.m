function plot3VerticalCorrections( sommeZ_REF_vect, sommeZ_TEST2_vect, sommeZ_TEST3_vect,  size_voxel , nameout)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

%if(ismatrix(sommeZ_REF_vect))
%sommeZ_REF_vect = sommeZ_REF_vect(:,1) + sommeZ_REF_vect(:,2);
%end

H_voxels = numel(sommeZ_REF_vect);


for i = 1:10:H_voxels; 
H_meters = i*size_voxel;
end

y = 0.1:size_voxel:(H_voxels*size_voxel);

figure;
%subplot(1,2,1);
plot(sommeZ_REF_vect,y,'R'); hold on;
plot(sommeZ_TEST2_vect*6,y,'B'); hold on;
plot(sommeZ_TEST3_vect*6,y,'k'); hold on;
leg_ =legend('LARCHI','(LVOX + nodata = 0) x C','(LVOX + (nodata = moy) + mask) x C');
set(leg_,'Interpreter','Latex','FontSize',14);

xlabel('DST moyen par couche horizontale (en $m^{2}/m^{3}$) ', 'Interpreter','Latex','FontSize',16);
ylabel('Hauteur Z (en metres)','Interpreter','Latex','FontSize',16);
title(nameout);

%subplot(1,2,1);
%plot()


path = strcat('/home/florentin/Dropbox/',nameout);

%export_fig ('-q101' ,'-a1','-transparent',path );





end

