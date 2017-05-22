function processOneSetOfGrid( densityGrid_path, binaryGrid_path, hitsTOTAL_path, SetOfGridName)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
if nargin <1
     error('not enought arguments')
end




%% Traitement d'un jeu de grilles de meme dimension
    % Chargement des grilles
[dim, scan_pos, size_voxel, grid3D_value, grid3D_binar] = read_BINARY_GRID(binaryGrid_path);
[dim, scan_pos, size_voxel, noData, grid3D_noData, grid3D_lvox_nonul, grid3D_, kmoy] = read_LVOX_GRID(densityGrid_path);
% Remplacement et masquage des valeurs manquantes
replace50;

if nargin==4
    [dim, scan_pos, size_voxel, grid3D_TOTAL_value, grid3D_binar] = read_BINARY_GRID(hitsTOTAL_path);
    grid3D_TOTAL_value(grid3D_value==0)=0; % On ne garde que les voxels de l'arbre cible
    result = {size_voxel,grid3D_lvox_corrected,grid3D_,grid3D_value,grid3D_TOTAL_value,grid3D_binar};
end

if nargin<4
    SetOfGridName = hitsTOTAL_path;
    result = {size_voxel,grid3D_lvox_corrected,grid3D_,grid3D_value,grid3D_binar};
end




save(strcat(SetOfGridName,'.mat'), 'result');
% profile_density_LVOX( grid3D_value, grid3D_noData,strcat(SetOfGridName,'non corrigée') , size_voxel );
% profile_density_LVOX( grid3D_lvox_corrected, grid3D_noData,strcat(SetOfGridName,'corrigée') , size_voxel );

end

