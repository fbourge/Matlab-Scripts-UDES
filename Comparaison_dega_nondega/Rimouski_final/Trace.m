function Trace( sommeYZ, sommeXZ, sommeZ1, sommeZ2, sommeXY, size_voxel, filename)
%TRACE Summary of this function goes here
%   Detailed explanation goes here

scaleZ = (size_voxel:size_voxel:size(sommeZ1,1)*size_voxel)'; % nouvelle �chelle en m�tres


%% Trace
figure('Name',filename,'NumberTitle','off', 'Position', [0 100 1200 1000]);

sub1 = subplot(2,2,1);
imagesc(sommeXY,'Parent', sub1);
axis('xy','fill');
xlabel('Y');
ylabel('X');
%colorbar('peer',sub1);

sub2 = subplot(2,2,2);
imagesc(sommeXZ,'Parent', sub2);
axis('xy','fill');
xlabel('Z');
ylabel('X');

sub3 = subplot(2,2,3);
imagesc(sommeYZ','Parent', sub3);
axis('xy','fill');
xlabel('Y');
ylabel('Z');

sub4 = subplot(2,2,4);
plotyy(scaleZ,sommeZ1,scaleZ,sommeZ2, 'Parent', sub4);
xlabel('Z');
ylabel('Densité Cumulée');


end

