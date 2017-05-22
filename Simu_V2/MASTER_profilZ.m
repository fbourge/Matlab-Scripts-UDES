placette = '10100317';
placette = '18600518';

path_grid3D_rescaled = strcat(placette,'/FINAL_workspace_resized.mat');
path_grid3D_value = strcat(placette,'/grid3D_BINARY_resized.mat');
path_grid3D_lvox = strcat(placette,'/grid3D_LVOX_resized.mat');

% load 10100317/workspace_grid3D_LARCHI_resized.mat grid3D_rescaled
% load 10100317/grid3D_BINARY_resized.mat grid3D_value
% load 10100317/grid3D_LVOX_resized.mat grid3D_lvox_nonul grid3D_lvox_corrected gridNoData size_voxel 


load(path_grid3D_rescaled,'grid3D_rescaled','size_voxel');
load(path_grid3D_value,'grid3D_value');



[ sommeYZ_LARCHI, sommeXZ_LARCHI, sommeZ1_LARCHI, sommeZ2_LARCHI, sommeXY_LARCHI ] = profile_density_LARCHI( grid3D_rescaled, 'LARCHI', size_voxel, 0 );
%[ sommeYZ_Lvox_null, sommeXZ_Lvox_null, sommeZ1_Lvox_null, sommeZ2_Lvox_null, sommeXY_Lvox_null, sommeNoData_Lvox_null ] = profile_density_LVOX( grid3D_lvox_nonul,gridNoData, 'LVOX not corrected', size_voxel );
%[ sommeYZ_Lvox, sommeXZ_Lvox, sommeZ1_Lvox, sommeZ2_Lvox, sommeXY_Lvox, sommeNoData_Lvox ] = profile_density_LVOX( grid3D_lvox_corrected,gridNoData, 'LVOX', size_voxel );
[ sommeYZ_Hits, sommeXZ_Hits, sommeXY_Hits, sommeZ1_Hits, sommeZ2_Hits ] = profile_density_Hits( grid3D_value);

%plot3VerticalCorrections( sommeZ1_LARCHI, sommeZ1_Lvox_null, sommeZ1_Lvox, sommeZ1_Lvox*2,  sommeZ1_Hits, size_voxel , 'Z profile');
plot_HitsvsPlantDensity( sommeZ1_Hits, sommeZ1_LARCHI, size_voxel, placette, 'HitsvsDensity');