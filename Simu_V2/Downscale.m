function [ grid3D_LARCHI_rescaled, dim_rescaled ] = Downscale( grid3D_source, downfactor)
%DOWNSCALE Summary of this function goes here
%   Detailed explanation goes here


dim_rescaled = size(grid3D_source);
m_4D = ndims(grid3D_source)==4;


cutnumbers = mod(dim_rescaled(1:3),downfactor); % on calcul le reste de la division entière que l'on souhaite réaliser
dim_rescaled(1:3)=dim_rescaled(1:3)-cutnumbers; % on coupe les voxels finaux de manière à obtenir des dimensions multiples de la résolution souhaitée

dim_rescaled(1:3) = dim_rescaled(1:3)/downfactor; % on réduit les dimensions 3 premières

grid3D_LARCHI_rescaled = zeros(dim_rescaled); % on créer une matrice de 0 aux nouvelles dimensions.


for z=1:dim_rescaled(3)
    dz = downfactor*(z - 1) + 1;
    for y=1:dim_rescaled(2)
        dy = downfactor*(y - 1) + 1;
        for x=1:dim_rescaled(1)
            dx = downfactor*(x - 1) + 1;
            
            if(m_4D)
                if (x==1 & y==1) z
                end
              SUB = grid3D_source(dx:(dx+downfactor-1),dy:(dy+downfactor-1),dz:(dz+downfactor-1),:); % extraction du super voxel
              sum_(1) = sum(sum(sum(SUB(:,:,:,1)))); % sommation du super voxel
              sum_(2) = sum(sum(sum(SUB(:,:,:,2))));
              grid3D_LARCHI_rescaled(x,y,z,:) = sum_ /(downfactor^3);% POURQUOI ?

%             z1(1:2) = (grid3D_source(dx,dy,dz,:) + grid3D_source(dx+1,dy,dz,:) + grid3D_source(dx,dy+1,dz,:) + grid3D_source(dx+1,dy+1,dz,:))/4;
%             z2(1:2) = (grid3D_source(dx,dy,dz+1,:) + grid3D_source(dx+1,dy,dz+1,:) + grid3D_source(dx,dy+1,dz+1,:) + grid3D_source(dx+1,dy+1,dz+1,:))/4;
%             grid3D_LARCHI_rescaled(x,y,z,:) = (z1+z2)/2;
            else
              SUB = grid3D_source(dx:(dx+downfactor-1),dy:(dy+downfactor-1),dz:(dz+downfactor-1));
              sum_ = sum(sum(sum(SUB)));
              grid3D_LARCHI_rescaled(x,y,z) = sum_ /(downfactor^3);%  POURQUOI ?
                
%             z1 = (grid3D_source(dx,dy,dz) + grid3D_source(dx+1,dy,dz) + grid3D_source(dx,dy+1,dz) + grid3D_source(dx+1,dy+1,dz))/4;
%             z2 = (grid3D_source(dx,dy,dz+1) + grid3D_source(dx+1,dy,dz+1) + grid3D_source(dx,dy+1,dz+1) + grid3D_source(dx+1,dy+1,dz+1))/4;
%             grid3D_LARCHI_rescaled(x,y,z) = (z1+z2)/2;    
            end
        end
    end
end
  

end

