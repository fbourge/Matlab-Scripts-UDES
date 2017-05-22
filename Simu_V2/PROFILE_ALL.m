function [sommeZ1_LARCHI, sommeZ1_HITS, sommeZ1_PAD, sommeZ1_IDR ] =  PROFILE_ALL( grid3D_LARCHI, grid3D_HITS, grid3D_Interpolated, grid3D_PAD, size_voxel, placette)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here



[ sommeYZ_LARCHI, sommeXZ_LARCHI, sommeZ1_LARCHI, sommeZ2_LARCHI, sommeXY_LARCHI ] = profile_density_LARCHI( grid3D_LARCHI, strcat('LARCHI ', num2str(100*size_voxel),' cm'), size_voxel, 0);
[ sommeYZ_Lvox, sommeXZ_Lvox, sommeXY_Lvox, sommeZ1_HITS, sommeZ2_HITS,  ] = profile_density_Hits( grid3D_HITS );
[ sommeYZ_Lvox, sommeXZ_Lvox, sommeZ1_IDR, sommeZ2_IDR, sommeXY_Lvox ] = profile_density_LVOX( grid3D_Interpolated, strcat('IDR ', num2str(100*size_voxel),' cm'), size_voxel, 0 );
[ sommeYZ_Lvox, sommeXZ_Lvox, sommeZ1_PAD, sommeZ2_PAD, sommeXY_Lvox ] = profile_density_LVOX( grid3D_PAD, strcat('PAD ', num2str(100*size_voxel),' cm'), size_voxel, 0 );

MINMAX = minmax(sommeZ1_LARCHI)
MEAN_LARCHI = mean(sommeZ1_LARCHI)



plot_REFvsHitsvsDensityCorrected( sommeZ1_LARCHI(:,1), sommeZ1_HITS, sommeZ1_PAD , sommeZ1_IDR , size_voxel , placette);

end

