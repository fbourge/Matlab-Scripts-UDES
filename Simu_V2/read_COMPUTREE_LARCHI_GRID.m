function [dim_A, grid_pos_A, size_A, grid3D_larchi_surfaces] = read_COMPUTREE_LARCHI_GRID(filename)

disp (strcat('>> Read LARCHI GRID : ',filename));

%% Open the file .grid
fid = fopen(filename, 'r');
if(fid == -1) 
    error('Error opening file')
end

%%%%%%%%%%%%%%%%%%%%%%
%% Reading the header
%%%%%%%%%%%%%%%%%%%%%%

%% Get the dim_Aension of the matrix in the x-,y-,z-direction
dim_A = [0 0 0];
for i = 1:3
    fscanf(fid,'%s',1);
    dim_A(i) = fscanf(fid,'%d',1);
end


%% Get the grid position xmin, ymin, zmin
grid_pos_A = [0 0 0];
 for i = 1:3
     fscanf(fid,'%s',1);
     grid_pos_A(i) = fscanf(fid,'%f',1);
 end
 

%% Get the size_A of the voxel
size_A = 0;
    fscanf(fid,'%s',1);
    size_A = fscanf(fid,'%f',1);
 

%% Get the NODATA Value
noData = 0;
    fscanf(fid,'%s',1);
    noData = fscanf(fid,'%f',1);
 

Redim_A = [0 dim_A(1);0 dim_A(2); 0 dim_A(3)];

%% Get the LARCHI value

grid3D_larchi_surfaces = zeros((Redim_A(1,2)-Redim_A(1,1)),(Redim_A(2,2)-Redim_A(2,1)),dim_A(3));

for k=1:dim_A(3)
    for j=dim_A(2):-1:1 % Watch out the proper browsing sense
        for i=1:dim_A(1)
            LARCHI_value = fscanf(fid,'%f',1);
            
            if (i>Redim_A(1,1) && j>Redim_A(2,1) && i<=Redim_A(1,2) && j<=Redim_A(2,2))
                % In case of proper data
                    grid3D_larchi_surfaces(i-Redim_A(1,1),j-Redim_A(2,1),k)=LARCHI_value;
            end
        end
    end
end


%% Closing and exit
fclose(fid);


end



