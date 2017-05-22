function [ sommeYZ, sommeXZ, sommeZ1, sommeZ2, sommeXY ] = density_Binar( grid3D_value, filename, size_voxel )

dim_X    = size(grid3D_value,1);
dim_Y    = size(grid3D_value,2);
dim_Z    = size(grid3D_value,3);


%% Projection 2D sur YZ par sommation des colonnes selon X (Y variable)
sommeYZ = sum(grid3D_value,1);
sommeYZ = reshape(sommeYZ,dim_Y,dim_Z);

%% Projection 2D sur XZ par sommation des colonnes selon Y (X variable)
sommeXZ = sum(grid3D_value,2);
sommeXZ = reshape(sommeXZ,dim_X,dim_Z);

%% Projection 2D sur XY par sommation des colonnes selon Z (X variable)
sommeXY = sum(grid3D_value,3);
sommeXY = reshape(sommeXY,dim_X,dim_Y);



%% Projection 1D sur Z par sommation des colonnes X et Y
sommeZ1  = zeros(dim_Z,1);
sommeZ2  = zeros(dim_Z,1);

TOTAL_YZ = sum(sum(sommeYZ));
TOTAL_XZ = sum(sum(sommeXZ));


for k=1:dim_Z;
    sommeZ1(k) = sum(sommeYZ(:,k))/TOTAL_YZ;

    sommeZ2(k) = sum(sommeXZ(:,k))/TOTAL_XZ;

end



sommeXY = sommeXY./(dim_Z); % ON divise par le nombre de voxels additionn�s par pixel
sommeXZ = sommeXZ./(dim_Y);
sommeYZ = sommeYZ./(dim_X);

sommeNoData = zeros(size(sommeZ1,1),1).*(-1);
 
Trace( sommeYZ, sommeXZ, sommeZ1, sommeZ2, sommeXY, size_voxel, filename, sommeNoData );


end