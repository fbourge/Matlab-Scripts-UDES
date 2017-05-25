clear;

EE_Av = '/Av/output/';
EE_Ap = '/Apres/output/';
EE    = {'Erable_Erable','ee',EE_Av,EE_Ap};

SE_Av = '/S.E_avant_output/';
SE_Ap = '/S.E_apres_output/';
SE    = {'Sapin_Erable','se',SE_Av,SE_Ap};

SS1_Av = '/S.S_avant_output/S1/';
SS1_Ap = '/S.S_apres_output/S1/';
SS1    = {'Sapin_Sapin','ss1',SS1_Av,SS1_Ap};

SS2_Av = '/S.S_avant_output/S2/';
SS2_Ap = '/S.S_apres_output/S2/';
SS2    = {'Sapin_Sapin','ss2',SS2_Av,SS2_Ap};

SS3_Av = '/S.S_avant_output/S3/';
SS3_Ap = '/S.S_apres_output/S3/';
SS3    = {'Sapin_Sapin','ss3',SS3_Av,SS3_Ap};


resolution_10cm = '10';
resolution_15cm = '15';
resolution_20cm = '20';

% Les variables principales
placette = {EE, SE, SS1, SS2, SS3};
resolution = {'10','15','20'};
typename = {'_avant_','_apres_'};


%% READ Computed grids
for p=1:5 % Cinq placettes
    for r=1:1 % Trois resolutions
        for mtype=1:2 % Avant et apres degagement

            placettePath = strcat(placette{p}{1},placette{p}{mtype + 2});

            PAD_gridpath = strcat(placettePath,'PAD/lvox_',resolution{r},'cm_ntnb50_density.GRD3D');
            IDR_gridpath = strcat(placettePath,'PAD/lvox_',resolution{r},'cm_ntnb50_Conbined_interpolated_density.GRD3D');
            hits_gridpath = strcat(placettePath,'PAD/hits_',resolution{r},'cm_TOTAL.GRD3D');
            TOTALHits_gridpath = strcat(placettePath,'hits_',resolution{r},'cm_TOTAL.GRD3D');
            Tree_gridpath = strcat(placettePath,'lvox_',resolution{r},'cm_ntnb50_hits_tree.GRD3D');
            filename_mat = strcat(placette{p}{2},typename{mtype},resolution{r},'.mat');

            if(isempty(ls(filename_mat)))

                % READ GRIDS
                [ grid3D_PAD, bbox_PAD_minimal, grid_pos_PAD_mini, dim_PAD, size_PAD  ] = READ_GRIDS( PAD_gridpath );
                [ grid3D_IDR, bbox_IDR_minimal, grid_pos_IDR_mini, dim_IDR, size_IDR  ] = READ_GRIDS( IDR_gridpath );
                [ grid3D_tree, bbox_tree_minimal, grid_pos_tree_mini, dim_tree, size_tree  ] = READ_GRIDS( Tree_gridpath );

                if(mtype == 1) % avant
                    [ grid3D_TOTAL_Hits, bbox_TOTAL_Hits_minimal, grid_pos_TOTAL_Hits_mini, dim_TOTAL_Hits, size_TOTAL_Hits  ] = READ_GRIDS( TOTALHits_gridpath );
                else % apres
                    %[ grid3D_BEST_CANDIDATE_Hits, bbox_BEST_CANDIDATE_Hits_minimal, grid_pos_BEST_CANDIDATE_Hits_mini, dim_BEST_CANDIDATE_Hits, size_BEST_CANDIDATE_Hits  ] = READ_GRIDS( hits_gridpath );
                    % Just fix it
                    grid3D_TOTAL_Hits = grid3D_tree;
                    grid_pos_TOTAL_Hits_mini = grid_pos_tree_mini;
                end

                % FITTING MATRIX
                [ grid3D_PAD_tree, dimOutPADTree ] = fitAtoB(grid3D_PAD, grid_pos_PAD_mini',grid3D_tree, grid_pos_tree_mini, size_PAD  );
                [ grid3D_IDR_tree, dimOutIDRTree ] = fitAtoB(grid3D_IDR, grid_pos_IDR_mini',grid3D_tree, grid_pos_tree_mini, size_tree  );
                [ grid3D_TOTAL_Hits_tree, dimOutHitsTree ] = fitAtoB(grid3D_TOTAL_Hits, grid_pos_TOTAL_Hits_mini',grid3D_tree, grid_pos_tree_mini, size_tree  );

                % ELIMINATE FOREIGN MATERIALS
                grid3D_PAD_tree(grid3D_tree <= 0) = 0;
                grid3D_IDR_tree(grid3D_tree <= 0) = 0;
                grid3D_TOTAL_Hits_tree(grid3D_tree <= 0) = 0;

                result = {size_PAD,grid3D_PAD_tree,grid3D_IDR_tree,grid3D_TOTAL_Hits_tree};

                save(filename_mat, 'result','grid3D_tree','grid_pos_tree_mini',...
                    'size_PAD',...
                    'grid3D_PAD_tree',...
                    'grid3D_IDR_tree',...
                    'grid3D_TOTAL_Hits_tree');

            else
                load(filename_mat);
            end
        end

       [A_sommeXZ_Lvox,B_sommeXZ_Lvox,scaleZ] = compare2SetOfGrids( placette{p}{2}, resolution{r},1);

    end
end
