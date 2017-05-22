function [dim, scan_pos, size, grid3D_value, grid3D_binar] = read_BINARY_GRID(filename)

%% Open the file .grid
fid = fopen(filename, 'r');
if(fid == -1) 
    error('Error opening file')
end

%%%%%%%%%%%%%%%%%%%%%%
%% Reading the header
%%%%%%%%%%%%%%%%%%%%%%

%% Get the dimension of the matrix in the x-,y-,z-direction
dim = [0 0 0];
for i = 1:3
    fscanf(fid,'%s',1);
    dim(i) = fscanf(fid,'%d',1);
end


%% Get the scan position xmin, ymin, zmin
scan_pos = [0 0 0];
 for i = 1:3
     fscanf(fid,'%s',1);
     scan_pos(i) = fscanf(fid,'%f',1);
 end
 

%% Get the size of the voxel
size = 0;
    fscanf(fid,'%s',1);
    size = fscanf(fid,'%f',1);
 

%% Get the NODATA Value
noData = 0;
    fscanf(fid,'%s',1);
    noData = fscanf(fid,'%f',1);
 


%% Get the density value
grid3D_value = zeros(dim(1),dim(2),dim(3)); % Need to respect this structure in order to still compatible with density function
grid3D_binar = grid3D_value;


for k=1:dim(3)
    for j=dim(2):-1:1 % Watch out the proper browsing sense
        for i=1:dim(1)
            grid3D_value(i,j,k) = fscanf(fid,'%f',1);
           
            if(grid3D_value(i,j,k)>0)
                grid3D_binar(i,j,k)=1;
            end
             
        end
    end
end




%% Closing and exit
fclose(fid);


end

