function saveCoupe( input, n, nameOutput )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

if(ndims(input)==4)
imagesc(input(:,:,n,1)+input(:,:,n,2));
else
imagesc(input(:,:,n));
end

axis image


path = strcat('/home/florentin/Dropbox/',nameOutput);

export_fig ('-q101' ,'-a1','-transparent',path );

end

