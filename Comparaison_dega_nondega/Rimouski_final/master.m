% %% Erable Erable
% 
% 10 cm avant
ee_avant_10_hits = 'Erable_Erable\Av\output\lvox_10cm_ntnb50_hits_tree.GRD3D';      % Grille des retours des voxels selectionnes avec max (nt-nb) de la zone de l'arbre
ee_avant_10_density = 'Erable_Erable\Av\output\lvox_10cm_ntnb50_density_tree.GRD3D';% Grille de densité des voxels selectionnes avec max (nt-nb) de la zone de l'arbre
ee_avant_10_Hits_TOTAL = 'Erable_Erable\Av\output\hits_10cm_TOTAL.GRD3D'; % Grille de la somme des retours de toutes les grilles
% % 10 cm après
% ee_apres_10_hits = 'Erable_Erable\Apres\output\lvox_10cm_ntnb50_hits_tree.GRD3D';
% ee_apres_10_density = 'Erable_Erable\Apres\output\lvox_10cm_ntnb50_density_tree.GRD3D';

% 15 cm avant
ee_avant_15_hits = 'Erable_Erable\Av\output\lvox_15cm_ntnb50_hits_tree.GRD3D';
ee_avant_15_density = 'Erable_Erable\Av\output\lvox_15cm_ntnb50_density_tree2.GRD3D';
ee_avant_15_Hits_TOTAL = 'Erable_Erable\Av\output\hits_15cm_TOTAL.GRD3D';
% % 15 cm après
% ee_apres_15_hits = 'Erable_Erable\Apres\output\lvox_15cm_ntnb50_hits_tree.GRD3D';
% ee_apres_15_density = 'Erable_Erable\Apres\output\lvox_15cm_ntnb50_density_tree.GRD3D';

% 20 cm avant
ee_avant_20_hits = 'Erable_Erable\Av\output\lvox_20cm_ntnb50_hits_tree.GRD3D';
ee_avant_20_density = 'Erable_Erable\Av\output\lvox_20cm_ntnb50_density_tree2.GRD3D';
ee_avant_20_Hits_TOTAL = 'Erable_Erable\Av\output\hits_20cm_TOTAL.GRD3D';
% % 20 cm après
% ee_apres_20_hits = 'Erable_Erable\Apres\output\lvox_20cm_ntnb50_hits_tree.GRD3D';
% ee_apres_20_density = 'Erable_Erable\Apres\output\lvox_20cm_ntnb50_density_tree.GRD3D';

% Chargement/correction de Erable Erable 10 cm
processOneSetOfGrid( ee_avant_10_density, ee_avant_10_hits,ee_avant_10_Hits_TOTAL,  'ee_avant_10');
% processOneSetOfGrid( ee_apres_10_density, ee_apres_10_hits, 'ee_apres_10');

% Chargement/correctionde Erable Erable 15 cm
processOneSetOfGrid( ee_avant_15_density, ee_avant_15_hits,ee_avant_15_Hits_TOTAL, 'ee_avant_15');
% processOneSetOfGrid( ee_apres_15_density, ee_apres_15_hits, 'ee_apres_15');

% Chargement/correction de Erable Erable 20 cm
processOneSetOfGrid( ee_avant_20_density, ee_avant_20_hits,ee_avant_20_Hits_TOTAL, 'ee_avant_20');
% processOneSetOfGrid( ee_apres_20_density, ee_apres_20_hits, 'ee_apres_20');
% 
% % ///////////////////////////////////////////////////////////////////////////////////////////
% 
% % %% Erable Sapin
% % % 10 cm avant
% % es_avant_10_hits = 'Erable_Sapin\E.S_avant_output\lvox_10cm_ntnb50_hits_tree.GRD3D';
% % es_avant_10_density = 'Erable_Sapin\E.S_avant_output\lvox_10cm_ntnb50_density_tree.GRD3D';
% % % 10 cm après
% % es_apres_10_hits = 'Erable_Sapin\E.S_apres_output\lvox_10cm_ntnb50_hits_tree.GRD3D';
% % es_apres_10_density = 'Erable_Sapin\E.S_apres_output\lvox_10cm_ntnb50_density_tree.GRD3D';
% % 
% % % 15 cm avant
% % es_avant_15_hits = 'Erable_Sapin\E.S_avant_output\output\lvox_15cm_ntnb50_hits_tree.GRD3D';
% % es_avant_15_density = 'Erable_Sapin\E.S_avant_output\output\lvox_15cm_ntnb50_density_tree.GRD3D';
% % % 15 cm après
% % es_apres_15_hits = 'Erable_Sapin\E.S_apres_output\lvox_15cm_ntnb50_hits_tree.GRD3D';
% % es_apres_15_density = 'Erable_Sapin\E.S_apres_output\lvox_15cm_ntnb50_density_tree.GRD3D';
% % 
% % % 20 cm avant
% % es_avant_20_hits = 'Erable_Sapin\E.S_avant_output\output\lvox_20cm_ntnb50_hits_tree.GRD3D';
% % es_avant_20_density = 'Erable_Sapin\E.S_avant_output\output\lvox_20cm_ntnb50_density_tree.GRD3D';
% % % 20 cm après
% % es_apres_20_hits = 'Erable_Sapin\E.S_apres_output\lvox_20cm_ntnb50_hits_tree.GRD3D';
% % es_apres_20_density = 'Erable_Sapin\E.S_apres_output\lvox_20cm_ntnb50_density_tree.GRD3D';
% % 
% % 
% % % Chargement/correction de Erable Sapin 10 cm
% % processOneSetOfGrid( es_avant_10_density, es_avant_10_hits, 'es_avant_10');
% % processOneSetOfGrid( es_apres_10_density, es_apres_10_hits, 'es_apres_10');
% % 
% % % Chargement/correctionde Erable Sapin 15 cm
% % processOneSetOfGrid( es_avant_15_density, es_avant_15_hits, 'es_avant_15');
% % processOneSetOfGrid( es_apres_15_density, es_apres_15_hits, 'es_apres_15');
% % 
% % % Chargement/correction de Erable Sapin 20 cm
% % processOneSetOfGrid( es_avant_20_density, es_avant_20_hits, 'es_avant_20');
% % processOneSetOfGrid( es_apres_20_density, es_apres_20_hits, 'es_apres_20');
% 
% % ///////////////////////////////////////////////////////////////////////////////////////////
% 
%% Sapin Erable
% 10 cm avant
se_avant_10_hits = 'Sapin_Erable\S.E_avant_output\lvox_10cm_ntnb50_hits_tree.GRD3D';
se_avant_10_density = 'Sapin_Erable\S.E_avant_output\lvox_10cm_ntnb50_density_tree.GRD3D';
se_avant_10_Hits_TOTAL = 'Sapin_Erable\S.E_avant_output\hits_10cm_TOTAL.GRD3D';
% % 10 cm après
% se_apres_10_hits = 'Sapin_Erable\S.E_apres_output\lvox_10cm_ntnb50_hits_tree.GRD3D';
% se_apres_10_density = 'Sapin_Erable\S.E_apres_output\lvox_10cm_ntnb50_density_tree.GRD3D';

% 15 cm avant
se_avant_15_hits = 'Sapin_Erable\S.E_avant_output\lvox_15cm_ntnb50_hits_tree.GRD3D';
se_avant_15_density = 'Sapin_Erable\S.E_avant_output\lvox_15cm_ntnb50_density_tree.GRD3D';
se_avant_15_Hits_TOTAL = 'Sapin_Erable\S.E_avant_output\hits_15cm_TOTAL.GRD3D';
% 15 cm après
se_apres_15_hits = 'Sapin_Erable\S.E_apres_output\lvox_15cm_ntnb50_hits_tree.GRD3D';
se_apres_15_density = 'Sapin_Erable\S.E_apres_output\lvox_15cm_ntnb50_density_tree2.GRD3D';

% 20 cm avant
se_avant_20_hits = 'Sapin_Erable\S.E_avant_output\lvox_20cm_ntnb50_hits_tree.GRD3D';
se_avant_20_density = 'Sapin_Erable\S.E_avant_output\lvox_20cm_ntnb50_density_tree.GRD3D';
se_avant_20_Hits_TOTAL = 'Sapin_Erable\S.E_avant_output\hits_20cm_TOTAL.GRD3D';
% 20 cm après
se_apres_20_hits = 'Sapin_Erable\S.E_apres_output\lvox_20cm_ntnb50_hits_tree.GRD3D';
se_apres_20_density = 'Sapin_Erable\S.E_apres_output\lvox_20cm_ntnb50_density_tree2.GRD3D';

% Chargement/correction de Erable Sapin 10 cm
processOneSetOfGrid( se_avant_10_density, se_avant_10_hits,se_avant_10_Hits_TOTAL, 'se_avant_10');
% processOneSetOfGrid( se_apres_10_density, se_apres_10_hits, 'se_apres_10');

% Chargement/correction de Erable Sapin 15 cm
processOneSetOfGrid( se_avant_15_density, se_avant_15_hits,se_avant_15_Hits_TOTAL, 'se_avant_15');
processOneSetOfGrid( se_apres_15_density, se_apres_15_hits, 'se_apres_15');

% Chargement/correction de Erable Sapin 20 cm
processOneSetOfGrid( se_avant_20_density, se_avant_20_hits,se_avant_20_Hits_TOTAL, 'se_avant_20');
processOneSetOfGrid( se_apres_20_density, se_apres_20_hits, 'se_apres_20');

% ///////////////////////////////////////////////////////////////////////////////////////////

% %% Sapin Sapin 1
% % 10 cm avant
% ss1_avant_10_hits = 'Sapin_Sapin\S.S_avant_output\S1\lvox_10cm_ntnb50_hits_tree.GRD3D';
% ss1_avant_10_density = 'Sapin_Sapin\S.S_avant_output\S1\lvox_10cm_ntnb50_density_tree.GRD3D';
% ss1_avant_10_hitsTOTAL = 'Sapin_Sapin\S.S_avant_output\S1\hits_10cm_TOTAL.GRD3D';
% % % 10 cm après
% % ss1_apres_10_hits = 'Sapin_Sapin\S.S_apres_output\S1\lvox_10cm_ntnb50_hits_tree.GRD3D';
% % ss1_apres_10_density = 'Sapin_Sapin\S.S_apres_output\S1\lvox_10cm_ntnb50_density_tree.GRD3D';
% 
% % 15 cm avant
% ss1_avant_15_hits = 'Sapin_Sapin\S.S_avant_output\S1\lvox_15cm_ntnb50_hits_tree.GRD3D';
% ss1_avant_15_density = 'Sapin_Sapin\S.S_avant_output\S1\lvox_15cm_ntnb50_density_tree.GRD3D';
% ss1_avant_15_hitsTOTAL = 'Sapin_Sapin\S.S_avant_output\S1\hits_15cm_TOTAL.GRD3D';
% % % 15 cm après
% % ss1_apres_15_hits = 'Sapin_Sapin\S.S_apres_output\S1\lvox_15cm_ntnb50_hits_tree.GRD3D';
% % ss1_apres_15_density = 'Sapin_Sapin\S.S_apres_output\S1\lvox_15cm_ntnb50_density_tree.GRD3D';
% 
% % 20 cm avant 
% ss1_avant_20_hits = 'Sapin_Sapin\S.S_avant_output\S1\lvox_20cm_ntnb50_hits_tree.GRD3D';
% ss1_avant_20_density = 'Sapin_Sapin\S.S_avant_output\S1\lvox_20cm_ntnb50_density_tree.GRD3D';
% ss1_avant_20_hitsTOTAL = 'Sapin_Sapin\S.S_avant_output\S1\hits_20cm_TOTAL.GRD3D';
% % % 20 cm après
% % ss1_apres_20_hits = 'Sapin_Sapin\S.s_apres_output\S1\lvox_20cm_ntnb50_hits_tree.GRD3D';
% % ss1_apres_20_density = 'Sapin_Sapin\S.S_apres_output\S1\lvox_20cm_ntnb50_density_tree.GRD3D';
% 
% 
% % Chargement/correction de Erable Sapin 10 cm
% processOneSetOfGrid( ss1_avant_10_density, ss1_avant_10_hits, ss1_avant_10_hitsTOTAL, 'ss1_avant_10');
% % processOneSetOfGrid( ss1_apres_10_density, ss1_apres_10_hits, 'ss1_apres_10');
% 
% % Chargement/correction de Erable Sapin 15 cm
% processOneSetOfGrid( ss1_avant_15_density, ss1_avant_15_hits, ss1_avant_15_hitsTOTAL, 'ss1_avant_15');
% % processOneSetOfGrid( ss1_apres_15_density, ss1_apres_15_hits, 'ss1_apres_15');
% 
% % Chargement/correction de Erable Sapin 20 cm
% processOneSetOfGrid( ss1_avant_20_density, ss1_avant_20_hits, ss1_avant_20_hitsTOTAL,  'ss1_avant_20');
% % processOneSetOfGrid( ss1_apres_20_density, ss1_apres_20_hits, 'ss1_apres_20');

%% Sapin Sapin 2
% 10 cm avant
ss2_avant_10_hits = 'Sapin_Sapin\S.S_avant_output\S2\lvox_10cm_ntnb50_hits_tree.GRD3D';
ss2_avant_10_density = 'Sapin_Sapin\S.S_avant_output\S2\lvox_10cm_ntnb50_density_tree.GRD3D';
ss2_avant_10_hitsTOTAL = 'Sapin_Sapin\S.S_avant_output\S2\hits_10cm_TOTAL.GRD3D';
% % 10 cm après
% ss2_apres_10_hits = 'Sapin_Sapin\S.S_apres_output\S2\lvox_10cm_ntnb50_hits_tree.GRD3D';
% ss2_apres_10_density = 'Sapin_Sapin\S.S_apres_output\S2\lvox_10cm_ntnb50_density_tree.GRD3D';

% 15 cm avant
ss2_avant_15_hits = 'Sapin_Sapin\S.S_avant_output\S2\lvox_15cm_ntnb50_hits_tree.GRD3D';
ss2_avant_15_density = 'Sapin_Sapin\S.S_avant_output\S2\lvox_15cm_ntnb50_density_tree.GRD3D';
ss2_avant_15_hitsTOTAL = 'Sapin_Sapin\S.S_avant_output\S2\hits_15cm_TOTAL.GRD3D';
% % 15 cm après
% ss2_apres_15_hits = 'Sapin_Sapin\S.S_apres_output\S2\lvox_15cm_ntnb50_hits_tree.GRD3D';
% ss2_apres_15_density = 'Sapin_Sapin\S.S_apres_output\S2\lvox_15cm_ntnb50_density_tree.GRD3D';

% 20 cm avant 
ss2_avant_20_hits = 'Sapin_Sapin\S.S_avant_output\S2\lvox_20cm_ntnb50_hits_tree.GRD3D';
ss2_avant_20_density = 'Sapin_Sapin\S.S_avant_output\S2\lvox_20cm_ntnb50_density_tree.GRD3D';
ss2_avant_20_hitsTOTAL = 'Sapin_Sapin\S.S_avant_output\S2\hits_20cm_TOTAL.GRD3D';
% % 20 cm après
% ss2_apres_20_hits = 'Sapin_Sapin\S.s_apres_output\S2\lvox_20cm_ntnb50_hits_tree.GRD3D';
% ss2_apres_20_density = 'Sapin_Sapin\S.S_apres_output\S2\lvox_20cm_ntnb50_density_tree.GRD3D';


%Chargement/correction de Erable Sapin 10 cm
processOneSetOfGrid( ss2_avant_10_density, ss2_avant_10_hits,ss2_avant_10_hitsTOTAL, 'ss2_avant_10');
% processOneSetOfGrid( ss2_apres_10_density, ss2_apres_10_hits, 'ss2_apres_10');

% Chargement/correction de Erable Sapin 15 cm
processOneSetOfGrid( ss2_avant_15_density, ss2_avant_15_hits,ss2_avant_15_hitsTOTAL, 'ss2_avant_15');
% processOneSetOfGrid( ss2_apres_15_density, ss2_apres_15_hits, 'ss2_apres_15');

% Chargement/correction de Erable Sapin 20 cm
processOneSetOfGrid( ss2_avant_20_density, ss2_avant_20_hits,ss2_avant_20_hitsTOTAL, 'ss2_avant_20');
% processOneSetOfGrid( ss2_apres_20_density, ss2_apres_20_hits, 'ss2_apres_20');

% Sapin Sapin 3
% 10 cm avant
ss3_avant_10_hits = 'Sapin_Sapin\S.S_avant_output\S3\lvox_10cm_ntnb50_hits_tree.GRD3D';
ss3_avant_10_density = 'Sapin_Sapin\S.S_avant_output\S3\lvox_10cm_ntnb50_density_tree.GRD3D';
ss3_avant_10_hitsTOTAL = 'Sapin_Sapin\S.S_avant_output\S3\hits_10cm_TOTAL.GRD3D';
% % 10 cm après
% ss3_apres_10_hits = 'Sapin_Sapin\S.S_apres_output\S3\lvox_10cm_ntnb50_hits_tree.GRD3D';
% ss3_apres_10_density = 'Sapin_Sapin\S.S_apres_output\S3\lvox_10cm_ntnb50_density_tree.GRD3D';

% 15 cm avant
ss3_avant_15_hits = 'Sapin_Sapin\S.S_avant_output\S3\lvox_15cm_ntnb50_hits_tree.GRD3D';
ss3_avant_15_density = 'Sapin_Sapin\S.S_avant_output\S3\lvox_15cm_ntnb50_density_tree.GRD3D';
ss3_avant_15_hitsTOTAL = 'Sapin_Sapin\S.S_avant_output\S3\hits_15cm_TOTAL.GRD3D';
% % 15 cm après
% ss3_apres_15_hits = 'Sapin_Sapin\S.S_apres_output\S3\lvox_15cm_ntnb50_hits_tree.GRD3D';
% ss3_apres_15_density = 'Sapin_Sapin\S.S_apres_output\S3\lvox_15cm_ntnb50_density_tree.GRD3D';

% 20 cm avant 
ss3_avant_20_hits = 'Sapin_Sapin\S.S_avant_output\S3\lvox_20cm_ntnb50_hits_tree.GRD3D';
ss3_avant_20_density = 'Sapin_Sapin\S.S_avant_output\S3\lvox_20cm_ntnb50_density_tree.GRD3D';
ss3_avant_20_hitsTOTAL = 'Sapin_Sapin\S.S_avant_output\S3\hits_20cm_TOTAL.GRD3D';
% % 20 cm après
% ss3_apres_20_hits = 'Sapin_Sapin\S.s_apres_output\S3\lvox_20cm_ntnb50_hits_tree.GRD3D';
% ss3_apres_20_density = 'Sapin_Sapin\S.S_apres_output\S3\lvox_20cm_ntnb50_density_tree.GRD3D';


% Chargement/correction de Erable Sapin 10 cm
 processOneSetOfGrid( ss3_avant_10_density, ss3_avant_10_hits,ss3_avant_10_hitsTOTAL, 'ss3_avant_10');
% processOneSetOfGrid( ss3_apres_10_density, ss3_apres_10_hits, 'ss3_apres_10');

% Chargement/correction de Erable Sapin 15 cm
processOneSetOfGrid( ss3_avant_15_density, ss3_avant_15_hits,ss3_avant_15_hitsTOTAL, 'ss3_avant_15');
% processOneSetOfGrid( ss3_apres_15_density, ss3_apres_15_hits, 'ss3_apres_15');

% Chargement/correction de Erable Sapin 20 cm
processOneSetOfGrid( ss3_avant_20_density, ss3_avant_20_hits,ss3_avant_20_hitsTOTAL, 'ss3_avant_20');
% processOneSetOfGrid( ss3_apres_20_density, ss3_apres_20_hits, 'ss3_apres_20');


% [A_sommeXZ_Lvox,B_sommeXZ_Lvox,scaleZ]=compare2SetOfGrids( 'se', '10');
% [A_sommeXZ_Lvox,B_sommeXZ_Lvox,scaleZ]=compare2SetOfGrids( 'se', '15');
% [A_sommeXZ_Lvox,B_sommeXZ_Lvox,scaleZ]=compare2SetOfGrids( 'se', '20');
% 
% [A_sommeXZ_Lvox,B_sommeXZ_Lvox,scaleZ]=compare2SetOfGrids( 'ee', '10');
% [A_sommeXZ_Lvox,B_sommeXZ_Lvox,scaleZ]=compare2SetOfGrids( 'ee', '15');
% [A_sommeXZ_Lvox,B_sommeXZ_Lvox,scaleZ]=compare2SetOfGrids( 'ee', '20');
% 
% [A_sommeXZ_Lvox,B_sommeXZ_Lvox,scaleZ]=compare2SetOfGrids( 'ss1', '10');
% [A_sommeXZ_Lvox,B_sommeXZ_Lvox,scaleZ]=compare2SetOfGrids( 'ss1', '15');
% [A_sommeXZ_Lvox,B_sommeXZ_Lvox,scaleZ]=compare2SetOfGrids( 'ss1', '20');
% 
% [A_sommeXZ_Lvox,B_sommeXZ_Lvox,scaleZ]=compare2SetOfGrids( 'ss2', '10');
% [A_sommeXZ_Lvox,B_sommeXZ_Lvox,scaleZ]=compare2SetOfGrids( 'ss2', '15');
% [A_sommeXZ_Lvox,B_sommeXZ_Lvox,scaleZ]=compare2SetOfGrids( 'ss2', '20');
% 
% [A_sommeXZ_Lvox,B_sommeXZ_Lvox,scaleZ]=compare2SetOfGrids( 'ss3', '10');
% [A_sommeXZ_Lvox,B_sommeXZ_Lvox,scaleZ]=compare2SetOfGrids( 'ss3', '15');
% [A_sommeXZ_Lvox,B_sommeXZ_Lvox,scaleZ]=compare2SetOfGrids( 'ss3', '20');