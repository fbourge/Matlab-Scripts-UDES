function [grid3D_resized, bbox_minimal, bbox_coord_minimal, dim, m_4D ] = minimal3D_BBox( grid3D_source, bbox_coord, size_voxel )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

% if nargin == 0
%     grid3D_source = evalin( 'base', 'grid3D_LARCHITECT_AREA' );
% end

m_4D = ndims(grid3D_source)==4;

 dim_X    = size(grid3D_source,1);
 dim_Y    = size(grid3D_source,2);
 dim_Z    = size(grid3D_source,3);
 
 X = [];
 Y = [];
 Z = [];
 
 
    for z=1:size(grid3D_source,3) %% Processus par tranche XY une par une.
        if m_4D
            [Xt,Yt] = find((grid3D_source(:,:,z,1)+grid3D_source(:,:,z,2))>0.02); %% Si un élément > 0 alors on enregistre ses coordonnées dans le plan XY
        else
            [Xt,Yt] = find(grid3D_source(:,:,z)>0.02); % idem
        end
            Zt = zeros(size(Xt,1),1)+z; % on créer un vecteur Zt de taille = Xt = Yt et on note le niveau z pour lequel les vecteurs Xt et Yt on enregistrés des valeurs

    X = [X;Xt]; % on empile les vecteurs de coordonnées des éléments non nuls.
    Y = [Y;Yt];
    Z = [Z;Zt];
    end

xminmax = minmax(X'); % On trouve les extremums pour chaque dimension
yminmax = minmax(Y');
zminmax = minmax(Z');
 
bbox_minimal = [xminmax(1) yminmax(1) zminmax(1) xminmax(2) yminmax(2) zminmax(2)];


dim = [range(xminmax)+1 range(yminmax)+1 range(zminmax)+1 2]; % creation du vecteur des dimensions spatiales

    

      if m_4D
      grid3D_resized = grid3D_source(xminmax(1):xminmax(2), yminmax(1):yminmax(2), zminmax(1):zminmax(2), :);
      else
      grid3D_resized = grid3D_source(xminmax(1):xminmax(2),yminmax(1):yminmax(2), zminmax(1):zminmax(2));     
      end
     
      
 bbox_coord_minimal = bbox_coord(1:3)' + ((bbox_minimal(1:3)-1).*size_voxel)';
     

end

