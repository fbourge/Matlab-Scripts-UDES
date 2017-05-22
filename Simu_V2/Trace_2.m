function Trace_2( sommeYZ, sommeXZ, sommeZ1, sommeZ2, sommeXY, error, size_voxel, filename )
%TRACE Summary of this function goes here
%   Detailed explanation goes here

scaleZ = (size_voxel:size_voxel:size(sommeZ1,1)*size_voxel)'; % nouvelle �chelle en m�tres


%% Trace
figure('Name',filename,'NumberTitle','off', 'Position', [0 100 1200 1000]);

sub1 = subplot(2,2,1);
imagesc(sommeXY(:,:,2)+sommeXY(:,:,1),'Parent', sub1);
imwrite(sommeXY(:,:,1),'feuillageXY.bmp');
axis('xy','fill');
xlabel('Y');
ylabel('X');
%colorbar('peer',sub1);

sub2 = subplot(2,2,2);
imagesc((sommeXZ(:,:,2)+sommeXZ(:,:,1)),'Parent', sub2);
axis('xy','fill');
xlabel('Z');
ylabel('X');

sub3 = subplot(2,2,3);
imagesc((sommeYZ(:,:,2)+sommeYZ(:,:,1))','Parent', sub3);
axis('xy','fill');
xlabel('Y');
ylabel('Z');

sub4 = subplot(2,2,4);
plot(scaleZ,sommeZ1, scaleZ ,sommeZ1(:,2) + sommeZ1(:,1),'Parent', sub4);
xlabel('Z');
ylabel('Densité Cumulée');
legend('feuillage','bois','cumul');

end

