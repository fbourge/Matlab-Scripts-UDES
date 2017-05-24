function [ grid3D_Zcm, bbox_X_minimal, grid_pos_X_mini, dim_X_Zcm, size_X_Zcm  ] = READ_GRIDS( filename_GRD3D )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

[dim_X_Zcm, grid_pos_X_Zcm, size_X_Zcm, grid3D_Zcm,grid_error] = read_COMPUTREE_PAD_GRID(filename_GRD3D);
grid_pos_X_Zcm = round (grid_pos_X_Zcm,3); % Arrondi au troisieme chiffre après la virgule.
[grid3D_Zcm, bbox_X_minimal, grid_pos_X_mini, dim_X_Zcm ] = minimal3D_BBox( grid3D_Zcm, grid_pos_X_Zcm, size_X_Zcm );

size_X_Zcm = round(size_X_Zcm, 3);


end

