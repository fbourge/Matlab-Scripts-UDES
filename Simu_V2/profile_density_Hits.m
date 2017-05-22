function [ sommeYZ_Hits, sommeXZ_Hits, sommeXY_Hits, sommeZ1_Hits, sommeZ2_Hits ] = profile_density_Hits( grid3D_value)

dim_X    = size(grid3D_value,1);
dim_Y    = size(grid3D_value,2);
dim_Z    = size(grid3D_value,3);


%% Projection 2D sur YZ par sommation des colonnes selon X (Y variable)
sommeYZ_Hits = sum(grid3D_value,1);
sommeYZ_Hits = reshape(sommeYZ_Hits,dim_Y,dim_Z);

%% Projection 2D sur XZ par sommation des colonnes selon Y (X variable)
sommeXZ_Hits = sum(grid3D_value,2);
sommeXZ_Hits = reshape(sommeXZ_Hits,dim_X,dim_Z);

%% Projection 2D sur XY par sommation des colonnes selon Z (X variable)
sommeXY_Hits = sum(grid3D_value,3);
sommeXY_Hits = reshape(sommeXY_Hits,dim_X,dim_Y);



%% Projection 1D sur Z par sommation des colonnes X et Y
sommeZ1_Hits  = zeros(dim_Z,1);
sommeZ2_Hits  = zeros(dim_Z,1);

TOTAL_YZ = sum(sum(sommeYZ_Hits));
TOTAL_XZ = sum(sum(sommeXZ_Hits));


sommeZ1_Hits = sum(sommeYZ_Hits)'/TOTAL_YZ; % on divise par la somme totale pour avoir
sommeZ2_Hits = sum(sommeXZ_Hits)'/TOTAL_XZ; % une valeur en pourcentage sur toute la hauteur



sommeXY_Hits = sommeXY_Hits./(dim_Z); % ON divise par le nombre de voxels additionn�s par pixel
sommeXZ_Hits = sommeXZ_Hits./(dim_Y);
sommeYZ_Hits = sommeYZ_Hits./(dim_X);

%sommeZ1_Hits = sum(sommeYZ_Lvox)'/((dim_X*dim_Y));
%sommeZ2_Hits = sum(sommeXZ_Lvox)'/((dim_X*dim_Y));


end