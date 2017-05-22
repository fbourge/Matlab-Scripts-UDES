function [dim_B, grid_pos_B, size_B, grid3D_PAD, grid_error] = read_COMPUTREE_PAD_GRID(filename)

disp (strcat('>> Read COMPUTREE GRID : ',filename));

%% Open the file .grid
fid = fopen(filename, 'r');
if(fid == -1) 
    error('Error opening file')
end

%%%%%%%%%%%%%%%%%%%%%%
%% Reading the header
%%%%%%%%%%%%%%%%%%%%%%

%% Get the dim_Bension of the matrix in the x-,y-,z-direction
dim_B = [0 0 0];
for i = 1:3
    fscanf(fid,'%s',1);
    dim_B(i) = fscanf(fid,'%d',1);
end


%% Get the grid position xmin, ymin, zmin
grid_pos_B = [0 0 0];
 for i = 1:3
     fscanf(fid,'%s',1);
     grid_pos_B(i) = fscanf(fid,'%f',1);
 end
 

%% Get the size_B of the voxel
size_B = 0;
    fscanf(fid,'%s',1);
    size_B = fscanf(fid,'%f',1);
 

%% Get the NODATA Value
noData = 0;
    fscanf(fid,'%s',1);
    noData = fscanf(fid,'%f',1);
 

num_material = 2;
num_erreur = 3;

Redim_B = [0 dim_B(1);0 dim_B(2); 0 dim_B(3)];
%% Get the PAD value
%grid3D = repmat(struct('mat',Material.none,'area',0,'volume',0),[(Redim_B(1,2)-Redim_B(1,1)) (Redim_B(2,2)-Redim_B(2,1)) dim_B(3) num_material]); % Need to respect this structure in order to still compatible with PAD function
grid_error = zeros(dim_B(1), dim_B(2), dim_B(3));


grid3D_PAD = zeros((Redim_B(1,2)-Redim_B(1,1)),(Redim_B(2,2)-Redim_B(2,1)),dim_B(3));

for k=1:dim_B(3)
    for j=dim_B(2):-1:1 % Watch out the proper browsing sense
        for i=1:dim_B(1)
            PAD = fscanf(fid,'%f',1);
            if (PAD == inf) PAD = 10000; end
            
            if (i>Redim_B(1,1) && j>Redim_B(2,1) && i<=Redim_B(1,2) && j<=Redim_B(2,2))
                % In case of proper data
                if (PAD>0)
                    grid3D_PAD(i,j,k)=PAD;
                else
                    grid_error(i,j,k)=PAD;
                end
                
            end
        end
    end
end
% 
% 
% for k=1:dim_B(3)
%     
%     adr=grid3D_(:,:,k)>0.0001;
% 
%     kmoy(k)=mean(grid3D_(adr));
%     
% end
% 
% % Extraction des valeurs non nulles et connues
% grid3D_lvox_nonul = zeros(dim_B(1),dim_B(2),dim_B(3));
% grid3D_lvox_nonul(grid3D_>0) = grid3D_(grid3D_>0);


%% Closing and exit
fclose(fid);


end



