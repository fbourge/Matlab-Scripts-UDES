function [ A, dimOut ] = fitAtoB( A, coordA, B, coordB, size_voxel  )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

dCoord = round(coordB' - coordA, 1);

dVoxel =  dCoord / size_voxel; % Nombre de voxels de décalage à la base de la grille
dVoxel = floor(dVoxel);


dimA = size(A);
dimB = size(B);
dimOut = zeros(1,3);
    %% Repositionnement des voxels à la base de la grille en cas de déficite
    for i=1:3
        if(dVoxel(i)<0) % Si les coordonnées à la base de la grille de référence sont plus petites que celles de la grille à formater on retraille la grille de référence

        dimA(i) = dimA(i) - dVoxel(i);
        coordA(i) = coordA(i) + dVoxel(i)*size_voxel;

        dimTmp = dimA;
        dimTmp(i)= abs(dVoxel(i));
        A = cat(i,zeros(dimTmp),A);  % Ajoute des plans en 2D à la base pour completer la dimension i déficitaire

        dCoord = round(coordB' - coordA, 1);
        dVoxel =  dCoord / size_voxel; % Nombre de voxels de décalage à la base de la grille
        dVoxel = floor(dVoxel); % doit être = 0
        end
    end


    dimOut = dimB;
    dimTmp = dimA;

    % Détection des dépassements aux extremums de la grille
    for i=1:3
        if(dVoxel(i) + dimB(i) > dimA(i)) % Si la grille à formater est plus petite que la grille de référence alors on ajoute les case manquantes.
            dimTmp(i) = dimB(i) -  (dimA(i) - dVoxel(i));
            A = cat(i,A,zeros(dimTmp));
        end
    end

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

