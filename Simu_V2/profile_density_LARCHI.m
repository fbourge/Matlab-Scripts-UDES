function [ sommeYZ_LARCHI, sommeXZ_LARCHI, sommeZ1_LARCHI, sommeZ2_LARCHI, sommeXY_LARCHI ] = profile_density_LARCHI( grid3D, filename, size_voxel, display )

% size_voxel2 = size_voxel*size_voxel;
  error=1;
%% grid3D %% 
%  = repmat(struct('mat',Material.none,'area',0,'volume',0),[dim(1) dim(2) dim(3) num_material]);
%  dim(1) = dim(X)
%  dim(2) = dim(Y)
%  dim(3) = dim(Z)
%  dim(4) = nombre de materiel maxi, normalement 2 : [feuillage,bois]
%  - Strucutre d'une case : - mat : type de matériel ( -1 = aucun, 0 = feuillage, 1 = bois )
%                           - area : aire surfacique du matériel dans le voxel
%                           - volume : volume du matériel dans le voxel
% 
%  Acces à la donnée :
%       grid3D(i,j,k,type).mat = s(m);          % its code (0,1,etc.)
%       grid3D(i,j,k,type).area = s(m+1);		% its surface area
%       grid3D(i,j,k,type).volume = s(m+2);     % its volume
%

dim_X    = size(grid3D,1);
dim_Y    = size(grid3D,2);
dim_Z    = size(grid3D,3);
dim_type = size(grid3D,4);


dim_X = dim_X;
dim_Y = dim_Y;
dim_Z = dim_Z;
% En 3D [X;Y;Type(Feuillage,Bois)]





%% Projection 2D sur YZ par sommation des colonnes selon X (Y variable)
sommeYZ_LARCHI(:,:,1) = sum(grid3D(:,:,:,1),1);
sommeYZ_LARCHI(:,:,1) = sommeYZ_LARCHI(:,:,1)./dim_X;

sommeYZ_LARCHI(:,:,2) = sum(grid3D(:,:,:,2),1);
sommeYZ_LARCHI(:,:,2) = sommeYZ_LARCHI(:,:,2)./dim_X;

%% Projection 2D sur XZ par sommation des colonnes selon Y (X variable)
sommeXZ_LARCHI(:,:,1) = sum(grid3D(:,:,:,1),2);
sommeXZ_LARCHI(:,:,1) = sommeXZ_LARCHI(:,:,1)./dim_Y;

sommeXZ_LARCHI(:,:,2) = sum(grid3D(:,:,:,2),2);
sommeXZ_LARCHI(:,:,2) = sommeXZ_LARCHI(:,:,2)./dim_Y;


%% Projection 2D sur XY par sommation des colonnes selon Z (X variable)
sommeXY_LARCHI(:,:,1) = sum(grid3D(:,:,:,1),3);
sommeXY_LARCHI(:,:,1) = sommeXY_LARCHI(:,:,1)./dim_Z;

sommeXY_LARCHI(:,:,2) = sum(grid3D(:,:,:,2),3);
sommeXY_LARCHI(:,:,2) = sommeXY_LARCHI(:,:,2)./dim_Z;


% %% Recadrage de la grille en XY
%  L1 = bwconvhull(sommeXY(:,:,1)); % enveloppe convexe pour le feuillage
%  L2 = bwconvhull(sommeXY(:,:,2)); % enveloppe convexe pour le bois
%  
%  L3 = L1 | L2;
%  STATS = regionprops(L3, 'BoundingBox');
% 
% xmin =  ceil(STATS.BoundingBox(2));
% xmax =  xmin + STATS.BoundingBox(4) ;
% ymin =  ceil(STATS.BoundingBox(1));
% ymax =  ymin + STATS.BoundingBox(3);
% 
% sommeXY=sommeXY(xmin:xmax , ymin:ymax ,:);
% 
% %% Recadrage de la grille en Z
%  L1 = bwconvhull(sommeXZ(:,:,1)); % enveloppe convexe pour le feuillage
%  L2 = bwconvhull(sommeXZ(:,:,2)); % enveloppe convexe pour le bois
%  
%  L3 = L1 | L2;
%  STATS = regionprops(L3, 'BoundingBox');
% 
%  zmin =  ceil(STATS.BoundingBox(1));
%  zmax =  zmin + STATS.BoundingBox(3);
%  
% sommeYZ = sommeYZ(ymin:ymax , zmin:zmax ,:);
% sommeXZ = sommeXZ(xmin:xmax , zmin:zmax ,:);
% 
%  dim_X    = xmax;
%  dim_Y    = ymax;
%  dim_Z    = zmax;
% 
%  bbox = [xmin xmax ymin ymax zmin zmax];

%% Projection 1D sur Z par sommation des colonnes X et Y
sommeZ1_LARCHI  = zeros(dim_Z,dim_type); % En 2D [Z;Type(Feuillage,Bois)]
sommeZ2_LARCHI  = zeros(dim_Z,dim_type); % En 2D [Z;Type(Feuillage,Bois)]


sommeZ1_LARCHI(:,1) = sum(sommeYZ_LARCHI(:,:,1))'/dim_Y;
sommeZ1_LARCHI(:,2) = sum(sommeYZ_LARCHI(:,:,2))'/dim_Y;


sommeZ2_LARCHI(:,1) = sum(sommeXZ_LARCHI(:,:,1))'/dim_X;
sommeZ2_LARCHI(:,2) = sum(sommeXZ_LARCHI(:,:,2))'/dim_X;



v = genvarname (filename);
eval([v '= sommeZ1_LARCHI;']);

sommeXY_LARCHI = real(sommeXY_LARCHI);
sommeYZ_LARCHI = real(sommeYZ_LARCHI);
sommeXZ_LARCHI = real(sommeXZ_LARCHI);
sommeZ1_LARCHI = real(sommeZ1_LARCHI); 
sommeZ2_LARCHI = real(sommeZ2_LARCHI);

%sommeXY_LARCHI = sommeXY_LARCHI./(dim_Z); % ON divise par le nombre de voxels additionn�s par pixel
%sommeXZ_LARCHI = sommeXZ_LARCHI./(dim_Y);
%sommeYZ_LARCHI = sommeYZ_LARCHI./(dim_X);


if(display)
    Trace_2( sommeYZ_LARCHI, sommeXZ_LARCHI, sommeZ1_LARCHI, sommeZ2_LARCHI, sommeXY_LARCHI, error, size_voxel, filename );
end

end