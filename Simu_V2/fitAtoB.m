function [ A, dimOut ] = fitAtoB( A, coordA, B, coordB, size_voxel  )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

dCoord = round(coordB' - coordA, 1);

dVoxel =  dCoord / size_voxel; % Nombre de voxels de d�calage � la base de la grille
dVoxel = floor(dVoxel);


dimA = size(A);
dimB = size(B);
dimOut = zeros(1,3);
    %% Repositionnement des voxels � la base de la grille en cas de d�ficite
    for i=1:3
        if(dVoxel(i)<0) % Si les coordonn�es � la base de la grille de r�f�rence sont plus petites que celles de la grille � formater on retraille la grille de r�f�rence

        dimA(i) = dimA(i) - dVoxel(i);
        coordA(i) = coordA(i) + dVoxel(i)*size_voxel;

        dimTmp = dimA;
        dimTmp(i)= abs(dVoxel(i));
        A = cat(i,zeros(dimTmp),A);  % Ajoute des plans en 2D � la base pour completer la dimension i d�ficitaire

        dCoord = round(coordB' - coordA, 1);
        dVoxel =  dCoord / size_voxel; % Nombre de voxels de d�calage � la base de la grille
        dVoxel = floor(dVoxel); % doit �tre = 0
        end
    end


    dimOut = dimB;
    dimTmp = dimA;

    % D�tection des d�passements aux extremums de la grille
    for i=1:3
        if(dVoxel(i) + dimB(i) > dimA(i)) % Si la grille � formater est plus petite que la grille de r�f�rence alors on ajoute les case manquantes.
            dimTmp(i) = dimB(i) -  (dimA(i) - dVoxel(i));
            A = cat(i,A,zeros(dimTmp));
        end
    end

%% R�sultat final

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

