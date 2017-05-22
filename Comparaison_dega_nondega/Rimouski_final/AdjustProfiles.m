function [ offset , correlation, ratio, profil_avant, A_diff, B_diff] = AdjustProfiles(profil_avant,profil_apres)
% Fitting different profiles from the same scene
%   The first profil is transformed step by steop in order to reach the optimal correlation with the second that is being kept absolutely intact 

%% Adjust size
A_size = size(profil_avant,1);
B_size = size(profil_apres,1);

delta_Z = A_size-B_size;
A_layer_min = min(profil_avant); % on cherche la valeur minimale comme valeur de remplissage par défaut
B_layer_min = min(profil_apres); % idem pour B

if(delta_Z<0) % Zmax(avant) < Zmax(apres) (normalement toujours vrai à cause de l'occlusion totale)
    
    A = vertcat(profil_avant,ones(abs(delta_Z),1)*A_layer_min); % on ajuste le nombre de couches
    
    fenetre_min = A_size;
    ratio = fenetre_min/B_size;

elseif (delta_Z>0) % Zmax(avant) > Zmax(apres),  on retire les couches couches hautes du premier profil pour ne garder que les couches en commun
    
    A = profil_avant(1:end-delta_Z); % on ajuste le nombre de couches
 
    fenetre_min = B_size;
    ratio = 1;
end

B = profil_apres;

%% Stepped superposition with correlation testing

D = 1; % windows size
offset = 0; % offset d'origine
correlation = corr(A,B); % corrélation d'origine

B1=vertcat(ones(D,1)*B_layer_min, B, ones(D,1)*B_layer_min); % On place B au milieu d'une une fenetre de travail
% % On test deux cas extrêmes
% % CAS 1
% % Décalage de A vers la gauche (négatif)
% A1= vertcat(A,ones(D,1)*A_layer_min);
% B1= vertcat(ones(D,1)*B_layer_min,B);
% 
% % CAS 2
% % Décalage de A vers la droite (positif)
% A2= vertcat(ones(D,1)*A_layer_min,A);
% B2= vertcat(B,ones(D,1)*B_layer_min);


for i =1:D
    
    corr_tmp1 = corr(A(1:fenetre_min),B1(D+1-i:D + fenetre_min -i));
    corr_tmp2 = corr(A(1:fenetre_min),B1(D+1+i:D + fenetre_min +i));
    
    % CAS 1
    if(corr_tmp1>correlation) 
        correlation=corr_tmp1;
        offset=-i;
    end
    
    % CAS 2
    if(corr_tmp2>correlation)
        correlation=corr_tmp2;
        offset=i;
    end
    
        
end

% Restitution des grilles recallées
% CAS 1
if(offset<0)
    profil_avant =  vertcat(A(1+abs(offset):end), ones(abs(offset),1)*A_layer_min);
    echo =  '1'
end

% CAS 2
if(offset>0)
    echo = '2'
    profil_avant =  vertcat( ones(offset,1)*A_layer_min, A(1:end-offset));
end

if(offset==0)
    echo = '3'
    profil_avant=A;
end


A_diff = size(profil_avant,1)-A_size;

B_diff = size(profil_apres,1)-B_size;

end

