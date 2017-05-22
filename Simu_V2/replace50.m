%% Replace mean data


% Need :
% + grid3D_             :   grille LVOX brute
% + grid3D_lvox_nonul   :   grille LVOX non nulle
% + grid3D_binar        :   grille binaire
% + n                   :   facteur de filtrage gaussien


Xdim = size(grid3D_lvox_nonul,1);
Ydim = size(grid3D_lvox_nonul,2);
Zdim = size(grid3D_lvox_nonul,3);

Zmeandata = sum(sum(grid3D_lvox_nonul));
Zmeandata = reshape(Zmeandata,Zdim,1);

Znbr = zeros(1,Zdim);

for z=1:Zdim
    Znbr(z) = size(find(grid3D_lvox_nonul(:,:,z)>0),1);
    if(Znbr(z)==0)
        Znbr(z)=1; end
end

Znbr=Znbr';
Zmeandata = Zmeandata./Znbr;

grid3D_lvox_corrected = grid3D_lvox_nonul;

%h = fspecial('average', n);

%% WARNING PARTIAL LOOP !
for z=[1:Zdim]
ZmeanDATA2D = zeros(Xdim, Ydim);
% Méthode avec mask binaire
ZmeanDATA2D(grid3D_(:,:,z)<0 & grid3D_binar(:,:,z)==1) = ZmeanDATA2D(grid3D_(:,:,z)<0 & grid3D_binar(:,:,z)==1) + Zmeandata(z);
% Méthode avec remplissage simple
%ZmeanDATA2D(grid3D_(:,:,z)<0 ) = ZmeanDATA2D(grid3D_(:,:,z)<0 ) + Zmeandata(z);
grid3D_lvox_corrected(:,:,z) =  grid3D_lvox_corrected(:,:,z) + ZmeanDATA2D;

%grid3D_lvox_corrected(:,:,z) = filter2(h, grid3D_lvox_corrected(:,:,z) );
%grid3D_lvox_corrected(grid3D_binar(:,:,z)==1) = grid3D_lvox_corrected(grid3D_binar(:,:,z)==1);

end

