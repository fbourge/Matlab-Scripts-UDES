function [ tranches ] = TraceStat( nbr_tranches, sommeXY, sommeXY_LARCHI, sommeXZ, sommeXZ_LARCHI, sommeYZ, sommeYZ_LARCHI, sommeZ1, sommeZ1_LARCHI  )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

Original_Data = struct('XY_LVOX',sommeXY,'XY_LARCHI',sommeXY_LARCHI, ...
                        'XZ_LVOX', sommeXZ, 'XZ_LARCHI',sommeXZ_LARCHI, ...
                        'YZ_LVOX', sommeYZ, 'YZ_LARCHI',sommeYZ_LARCHI, ...
                        'Z_LVOX', sommeZ1, 'Z_LARCHI',sommeZ1_LARCHI );
%nbr_tranches = 3;
 h = floor(size(Original_Data.Z_LVOX,1)/nbr_tranches)

 size_voxel = 0.1;
 scaleZ = (h*size_voxel:h*size_voxel:nbr_tranches*size_voxel*h)';

 min = 1;
 max = h;
tranches = {};     

 for i=1 : nbr_tranches
     
     
          Tranche_Data = struct('XY_LVOX',[],'XY_LARCHI',[], ...
                        'XZ_LVOX', [], 'XZ_LARCHI',[], ...
                        'YZ_LVOX', [], 'YZ_LARCHI',[], ...
                        'Z_LVOX', [], 'Z_LARCHI',[] );
     
     
         %% Addition du bois et du feuillage et mise en vecteur des donn�es sur des tranches verticales
    % XY
    [ Tranche_Data.XY_LVOX, Tranche_Data.XY_LARCHI ] = tranche_reshape( Original_Data.XY_LVOX , Original_Data.XY_LARCHI , 1, size(Original_Data.XY_LVOX,2) );

    % XZ
    [ Tranche_Data.XZ_LVOX, Tranche_Data.XZ_LARCHI ] = tranche_reshape( Original_Data.XZ_LVOX , Original_Data.XZ_LARCHI , min, max );

    % YZ
    [ Tranche_Data.YZ_LVOX, Tranche_Data.YZ_LARCHI ] = tranche_reshape( Original_Data.YZ_LVOX , Original_Data.YZ_LARCHI , min, max );

    % Z
    Tranche_Data.Z_LVOX = Original_Data.Z_LVOX(min:max,1);
    Tranche_Data.Z_LARCHI = Original_Data.Z_LARCHI(min:max,1) + Original_Data.Z_LARCHI(min:max,2);

     %% To do continuer la mise en tranche des donn�es

     new_tranche = {Tranche_Data};
          
     tranches = [tranches,new_tranche];
     
     min = max + 1;
     max = max + h;
     
 end
 
 tranches;
       nbr_tranches;             

TraceStat_script;

end

