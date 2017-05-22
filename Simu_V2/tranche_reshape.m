function [ vect_LVOX, vect_LARCHI ] = tranche_reshape( tab_LVOX, tab_LARCHI, min, max )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

    
    tab_LVOX_tmp = tab_LVOX(:,min:max);
    tab_LARCHI_tmp = tab_LARCHI(:,min:max,1) + tab_LARCHI(:,min:max,2);

    size_LVOX = total_size(tab_LVOX_tmp);
    size_LARCHI = total_size(tab_LARCHI_tmp);
    
    vect_LVOX = reshape (tab_LVOX_tmp,1,size_LVOX);
    vect_LARCHI = reshape (tab_LARCHI_tmp,1,size_LARCHI);

end

