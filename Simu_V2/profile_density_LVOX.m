function [ sommeYZ_Lvox, sommeXZ_Lvox, sommeZ1_Lvox, sommeZ2_Lvox, sommeXY_Lvox ] = profile_density_LVOX( grid3D_value, filename, size_voxel, display )

dim_X    = size(grid3D_value,1);
dim_Y    = size(grid3D_value,2);
dim_Z    = size(grid3D_value,3);

mean_input = mean(mean(mean(grid3D_value)));

%% Projection 2D sur YZ par sommation des colonnes selon X (Y variable)
sommeYZ_Lvox = sum(grid3D_value,1);
sommeYZ_Lvox = reshape(sommeYZ_Lvox,dim_Y,dim_Z);

%meanYZ = mean(mean(sommeYZ_Lvox))

%% Projection 2D sur XZ par sommation des colonnes selon Y (X variable)
sommeXZ_Lvox = sum(grid3D_value,2);
sommeXZ_Lvox = reshape(sommeXZ_Lvox,dim_X,dim_Z);

%meanXZ = mean(mean(sommeXZ_Lvox))

%% Projection 2D sur XY par sommation des colonnes selon Z (X variable)
sommeXY_Lvox = sum(grid3D_value,3);
sommeXY_Lvox = reshape(sommeXY_Lvox,dim_X,dim_Y);

%meanXY = mean(mean(sommeXY_Lvox))


%% Projection 1D sur Z par sommation des colonnes X et Y
sommeZ1_Lvox  = zeros(dim_Z,1);
sommeZ2_Lvox  = zeros(dim_Z,1);

%mean_Z1 = mean(sum(sommeZ1_Lvox))
%mean_Z2 = mean(sum(sommeZ2_Lvox))

TOTAL_YZ = sum(sum(sommeYZ_Lvox));
TOTAL_XZ = sum(sum(sommeXZ_Lvox));

%sommeZ1_Lvox = sum(sommeYZ_Lvox)'/TOTAL_YZ;
%sommeZ2_Lvox = sum(sommeXZ_Lvox)'/TOTAL_XZ;

sommeZ1_Lvox = sum(sommeYZ_Lvox)'/((dim_X*dim_Y));
sommeZ2_Lvox = sum(sommeXZ_Lvox)'/((dim_X*dim_Y));

%% Calcul du profil noDATA
% if(numel(grid3D_noData)==4)
% grid3D_noData = grid3D_noData(:,:,:,1)+grid3D_noData(:,:,:,2)+grid3D_noData(:,:,:,3);
% end
% sommeNoData_Lvox = sum(sum(grid3D_noData));
% sommeNoData_Lvox = reshape(sommeNoData_Lvox,size(grid3D_noData,3),1);

%sommeZ1 = sommeZ1.*(0.1*sommeNoData);


% 
% sommeXY_Lvox = sommeXY_Lvox./(dim_Z); % ON divise par le nombre de voxels additionn�s par pixel // Opération de normalisation si utile que ça ?
% sommeXZ_Lvox = sommeXZ_Lvox./(dim_Y);
% sommeYZ_Lvox = sommeYZ_Lvox./(dim_X);

if(display)
Trace( sommeYZ_Lvox, sommeXZ_Lvox, sommeZ1_Lvox, sommeZ2_Lvox, sommeXY_Lvox, size_voxel, filename );
end

end