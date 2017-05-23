function [ A, dimOut ] = fitAtoB( A, coordA, B, coordB, size_voxel  )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

dCoord = round(coordB' - coordA, 1);

dVoxel =  dCoord / size_voxel; % Nombre de voxels de décalage à la base de la grille
dVoxel = floor(dVoxel);


dimA= size(A);
dimB= size(B);
dimOut = zeros(1,3);
%%Out = zeros(dim(B));
    %% Détection de dépassement
    for i=1:3
        if(dVoxel(i)<0) % Si les coordonnées à la base de la grille de référence sont plus petites que celles de la grille à formater on retraille la grille de référence
        dimB(i)=dimB(i)+dVoxel(i);
        coordB(i)=coordB(i)-dVoxel(i)*size_voxel;

        dCoord = round(coordB' - coordA, 1);
        dVoxel =  dCoord / size_voxel; % Nombre de voxels de décalage à la base de la grille
        dVoxel = floor(dVoxel);

        end

        if(dVoxel(i)+dimB(i)>dimA(i)) % Si la grille Ã  formater est plus petite que la grille de rÃ©fÃ©rence alors on prend le maximum de voxel sans la dÃ©passer.
            dimOut(i) = dimA(i)-dVoxel(i);

        else
            dimOut(i) = dimB(i);
        end
    end

% for i =1:3
%     if(dimA(i)>dimB(i)) 
%         dimOut(i)=dimB(i);
%     else
%         dimOut(i)=dimA(i);
%     end
% end
%     
%     Out(1:dimOut(1), 1:dimOut(2),1:dimOut(3)) = A(1:dimOut(1), 1:dimOut(2),1:dimOut(3));
% 
%     

%% Résultat final

    vect = zeros(3,2);

    for i=1:3
            vect(i,:) = [dVoxel(i)+1 dVoxel(i)+dimOut(i)];
    end

    if(ndims(A)==4)
        A = A(vect(1,1):vect(1,2), ...
            vect(2,1):vect(2,2), ...
            vect(3,1):vect(3,2),:);
    else
        A = A(vect(1,1):vect(1,2), ...
            vect(2,1):vect(2,2), ...
            vect(3,1):vect(3,2));

    end


end

