clear;
placette317 = '10100317';
placette518 = '18600518';
placette805 = '18900805';
placette312 = '19502312';

resolution_10cm = '10';
resolution_15cm = '15';
resolution_20cm = '20';
PAD = {'PAD','B','PAD_ntnb'};
IDR = {'Interpolated','C','Interpolated_ntnb'};
HITS = {'HITS','D','Hits'};

% Les variables principales
placette = placette518;
resolution = {'10','15','20'};
name = {PAD; IDR; HITS};



%% READ Computed grids
for r=1:3 % Trois resolutions
    for n=1:3 % Trois types de grille


    filename_GRD3D = strcat(placette,'/',resolution{r},' cm','/New_2/',name{n}{3},'_',resolution{r},'cm.GRD3D')
    filename_mat = strcat(placette,'/',resolution{r},' cm','/New_2/',name{n}{3},'_',resolution{r},'cm.mat')

        if(isempty(ls(filename_mat)))

            [ grid3D_Zcm, bbox_X_minimal, grid_pos_X_mini, dim_X_Zcm, size_X_Zcm  ] = READ_GRIDS( filename_GRD3D );

            % Creation des noms de variable
            grid3D_Zcm_newname = ['grid3D_' name{n}{1} '_' resolution{r} 'cm'];
            bbox_X_minimal_newname = ['bbox_' name{n}{2} '_' resolution{r} 'cm'] ; 
            grid_pos_X_mini_newname = ['grid_pos_' name{n}{2} '_' resolution{r} 'cm' ];
            dim_X_Zcm_newname = ['dim_' name{n}{2} '_' resolution{r} 'cm' ];
            size_X_Zcm_newname = ['size_' name{n}{2} '_' resolution{r} 'cm' ];

            % Remplacement des noms génériques par des noms spécifiques
            eval([grid3D_Zcm_newname ' = grid3D_Zcm;']);
            eval([bbox_X_minimal_newname ' = bbox_X_minimal;']);
            eval([grid_pos_X_mini_newname ' = grid_pos_X_mini;']);
            eval([dim_X_Zcm_newname ' = dim_X_Zcm;']);
            eval([size_X_Zcm_newname ' = size_X_Zcm;']);

            save(filename_mat,...
                grid3D_Zcm_newname,...
                bbox_X_minimal_newname,...
                grid_pos_X_mini_newname,...
                dim_X_Zcm_newname,...
                size_X_Zcm_newname);

        else
            load(filename_mat);
        end
    end
end



%% READ LARCHI reference surface grids
filename_LARCHI_surfaces = strcat(placette,'/Surfaces_LARCHI.GRD3D');
filename_LARCHI_surfaces_mat = strcat(placette, '/Surfaces_LARCHI.mat');

% Test si la grille est déjà enregistrée
    if(isempty(ls(filename_LARCHI_surfaces_mat))) % si non
        % Lecture de la grille au format COMPUTREE
        [dim_A, grid_pos_A, size_A_5cm, grid3D_larchi_surfaces_5cm] = read_COMPUTREE_LARCHI_GRID(filename_LARCHI_surfaces);
        % Diminution de la dimension de la grille pour coller aux cases pleines extérieurs 
        [grid3D_LARCHI_5cm, bbox_A_minimal, grid_pos_A_mini, dim_A_5cm] = minimal3D_BBox( grid3D_larchi_surfaces_5cm, grid_pos_A, size_A_5cm );
        %
        save(filename_LARCHI_surfaces_mat,'grid3D_LARCHI_5cm','grid_pos_A_mini','dim_A_5cm','size_A_5cm');

    else % si elle est déjà enregistrée on la charge
        load(filename_LARCHI_surfaces_mat);
    end
    
 
    
% Rebase // Alignement fin de la base de la grille
    grid_pos_A_mini = round(grid_pos_A_mini,2);
    grid_pos_B_10cm = round(grid_pos_B_10cm,2);
    rebase = (grid_pos_A_mini - grid_pos_B_10cm)/size_A_5cm;
    rebase = round(rebase,2);
    
    dim_A_5cm = [dim_A_5cm(1)+rebase(1) dim_A_5cm(2)+rebase(2) dim_A_5cm(3)+rebase(3)]; 
    grid_pos_A_mini =[grid_pos_A_mini(1)-rebase(1)*size_A_5cm grid_pos_A_mini(2)-rebase(2)*size_A_5cm grid_pos_A_mini(3)-rebase(3)*size_A_5cm];
    
    grid3D_LARCHI_5cm_rebased= zeros(dim_A_5cm);
    grid3D_LARCHI_5cm_rebased(1+rebase(1):end,1+rebase(2):end,1+rebase(3):end) = grid3D_LARCHI_5cm;

%% Conversion de m2/voxel en m2/m3
    grid3D_LARCHI_5cm_rebased = grid3D_LARCHI_5cm_rebased./(size_A_5cm^3);
    grid3D_LARCHI_5cm_rebased = grid3D_LARCHI_5cm_rebased/2;
    
%% Downscaling
% Préparation des trois différents facteurs de diminution de la résolution
    downfactor_x2 = 2; % 5 cm to 10 cm
    size_A_10cm = size_A_5cm*downfactor_x2;
    downfactor_x3 = 3; % 5 cm to 15 cm
    size_A_15cm = size_A_5cm*downfactor_x3;
    downfactor_x4 = 4; % 5 cm to 20 cm
    size_A_20cm = size_A_5cm*downfactor_x4;

% Diminution de la résolution de la grille de référence LARCHI
    [ grid3D_LARCHI_10cm, dim_A_10cm  ] = Downscale( grid3D_LARCHI_5cm_rebased, downfactor_x2);
    [ grid3D_LARCHI_15cm, dim_A_15cm ] = Downscale( grid3D_LARCHI_5cm_rebased, downfactor_x3);
    [ grid3D_LARCHI_20cm, dim_A_20cm ] = Downscale( grid3D_LARCHI_5cm_rebased, downfactor_x4);

% Fitting de la grille PAD vers le format LARCHI
    [ grid3D_PAD_10cm, dim_B_10cm ] = fitAtoB( grid3D_PAD_10cm, grid_pos_B_10cm, grid3D_LARCHI_10cm, grid_pos_A_mini, size_B_10cm);
    [ grid3D_PAD_15cm, dim_B_15cm ] = fitAtoB( grid3D_PAD_15cm, grid_pos_B_15cm, grid3D_LARCHI_15cm, grid_pos_A_mini, size_B_15cm);
    [ grid3D_PAD_20cm, dim_B_20cm ] = fitAtoB( grid3D_PAD_20cm, grid_pos_B_20cm, grid3D_LARCHI_20cm, grid_pos_A_mini, size_B_20cm);

% Fitting de la grille d'IDR Interpolé vers le format LARCHI
    [ grid3D_Interpolated_10cm, dim_C_10cm ] = fitAtoB( grid3D_Interpolated_10cm, grid_pos_C_10cm, grid3D_LARCHI_10cm, grid_pos_A_mini, size_B_10cm);
    [ grid3D_Interpolated_15cm, dim_C_15cm ] = fitAtoB( grid3D_Interpolated_15cm, grid_pos_C_15cm, grid3D_LARCHI_15cm, grid_pos_A_mini, size_B_15cm);
    [ grid3D_Interpolated_20cm, dim_C_20cm ] = fitAtoB( grid3D_Interpolated_20cm, grid_pos_C_20cm, grid3D_LARCHI_20cm, grid_pos_A_mini, size_B_20cm);

% Fitting de la grille HITS vers le format LARCHI
    [ grid3D_HITS_10cm, dim_D_10cm ] = fitAtoB( grid3D_HITS_10cm, grid_pos_D_10cm, grid3D_LARCHI_10cm, grid_pos_A_mini, size_B_10cm);
    [ grid3D_HITS_15cm, dim_D_15cm ] = fitAtoB( grid3D_HITS_15cm, grid_pos_D_15cm, grid3D_LARCHI_15cm, grid_pos_A_mini, size_B_15cm);
    [ grid3D_HITS_20cm, dim_D_20cm ] = fitAtoB( grid3D_HITS_20cm, grid_pos_D_20cm, grid3D_LARCHI_20cm, grid_pos_A_mini, size_B_20cm);

    
    % Sauvegarde des grilles
%    save(filename_LARCHI_surfaces_mat,'grid3D_LARCHI_5cm_retailed','grid_pos_A_mini','dim_A_5cm','size_A_5cm','-append');
%    save(filename_LARCHI_surfaces_mat,'grid3D_LARCHI_10cm','dim_A_10cm','size_A_10cm','-append');
%    save(filename_LARCHI_surfaces_mat,'grid3D_LARCHI_15cm','dim_A_15cm','size_A_15cm','-append');
%    save(filename_LARCHI_surfaces_mat,'grid3D_LARCHI_20cm','dim_A_20cm','size_A_20cm','-append');
%clear;
%load(filename_LARCHI_surfaces,'grid3D_LARCHI_resized','grid_pos_A_mini','dim_A_rescaled');

%% Validity tests
    mat_5 = reshape(grid3D_LARCHI_5cm_rebased,dim_A_5cm(1)*dim_A_5cm(2)*dim_A_5cm(3),1);
    mat_10 = reshape(grid3D_LARCHI_10cm,dim_A_10cm(1)*dim_A_10cm(2)*dim_A_10cm(3),1);
    mat_15 = reshape(grid3D_LARCHI_15cm,dim_A_15cm(1)*dim_A_15cm(2)*dim_A_15cm(3),1);
    mat_20 = reshape(grid3D_LARCHI_20cm,dim_A_20cm(1)*dim_A_20cm(2)*dim_A_20cm(3),1);
% Moyenne identique
    mean_A(1)=mean(mat_5);
    mean_A(2)=mean(mat_10);
    mean_A(3)=mean(mat_15);
    mean_A(4)=mean(mat_20);
% Somme (totale) identique
    sum_A(1)=sum(mat_5)*(size_A_5cm^3); 
    sum_A(2)=sum(mat_10)*(size_A_10cm^3);
    sum_A(3)=sum(mat_15)*(size_A_15cm^3);
    sum_A(4)=sum(mat_20)*(size_A_20cm^3);
% Histogrammes par grille ?

% To-fix : on ajoute une dimension vide aux grilles pour garder la
% compatibilité avec les grilles bois/feuilles séparés
grid3D_LARCHI_5cm_rebased(:,:,:,2) = zeros(dim_A_5cm);
grid3D_LARCHI_10cm(:,:,:,2) = zeros(dim_A_10cm);
grid3D_LARCHI_15cm(:,:,:,2) = zeros(dim_A_15cm);
grid3D_LARCHI_20cm(:,:,:,2) = zeros(dim_A_20cm);

% Ecrêtage des valeurs de PAD trop haute (ni très grand et ni<nt-nb)
% grid3D_PAD_10cm__ = zeros (size(grid3D_PAD_10cm));
% grid3D_PAD_10cm__(grid3D_PAD_10cm(:,:,:)<60) = grid3D_PAD_10cm(grid3D_PAD_10cm(:,:,:)<60);
% grid3D_PAD_15cm__ = zeros (size(grid3D_PAD_15cm));
% grid3D_PAD_15cm__(grid3D_PAD_15cm(:,:,:)<60) = grid3D_PAD_15cm(grid3D_PAD_15cm(:,:,:)<60);
% grid3D_PAD_20cm__ = zeros (size(grid3D_PAD_20cm));
% grid3D_PAD_20cm__(grid3D_PAD_20cm(:,:,:)<60) = grid3D_PAD_20cm(grid3D_PAD_20cm(:,:,:)<60);

%% Calcul et tracage des profils
[sommeZ1_LARCHI_10cm, sommeZ1_HITS_10cm, sommeZ1_PAD_10cm, sommeZ1_IDR_10cm ]= PROFILE_ALL( grid3D_LARCHI_10cm, grid3D_HITS_10cm, grid3D_Interpolated_10cm*8, grid3D_PAD_10cm, size_A_10cm, placette);
[sommeZ1_LARCHI_15cm, sommeZ1_HITS_15cm, sommeZ1_PAD_15cm, sommeZ1_IDR_15cm ]= PROFILE_ALL( grid3D_LARCHI_15cm, grid3D_HITS_15cm, grid3D_Interpolated_15cm*8, grid3D_PAD_15cm, size_A_15cm, placette);
[sommeZ1_LARCHI_20cm, sommeZ1_HITS_20cm, sommeZ1_PAD_20cm, sommeZ1_IDR_20cm ]= PROFILE_ALL( grid3D_LARCHI_20cm, grid3D_HITS_20cm, grid3D_Interpolated_20cm*8, grid3D_PAD_20cm, size_A_20cm, placette);


