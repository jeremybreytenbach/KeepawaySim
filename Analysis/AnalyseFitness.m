%% load data
load(sprintf('..//Data//fitness8180.mat'));

fitness = real(fitness);
fitness(ismissing(fitness,0)) = nan;

%% basic stats
figure
histogram(fitness)
title('Fitness histogram')

%% 3d visualisation
[x,y,z] = meshgrid(1:100);

figure
scatter3(x(:),y(:),z(:),fitness(1:end))
title('Fitness landscape / Map of elites')
xlabel('team dispersion')
ylabel('no passes')
zlabel('dist from centre')

normFitness = normalize(fitness(1:end),'range');
normFitness(normFitness==0) = nan;

figure
scatter3(x(:),y(:),z(:),normFitness*100,normFitness*100,'filled')
xlabel('team dispersion')
ylabel('no passes')
zlabel('dist from centre')
title('Normalised fitness landscape / Map of elites')

colormap(jet);
colorbar;
%% More
% create heatmap from 3d matrix

% fitness2 = fitness*100;
% fitness3 = zscore(fitness);
% 
%  x = fitness(:,:,1);
%  y = fitness(:,:,2);
%  z = fitness(:,:,3);
%  figure; plot3(x,y,z,'.-'); %the figure is attached below
% 
% figure
% plot3(fitness(:,1,1),squeeze(fitness(1,:,1)),squeeze(fitness(1,1,:)),'o')
% 
% figure
% plot3(fitness2(:,1,1),squeeze(fitness2(1,:,1))',squeeze(fitness2(1,1,:)),'o')
% 
% figure
% plot3(fitness3(:,1,1),squeeze(fitness3(1,:,1)),squeeze(fitness3(1,1,:)),'o')
% 
% all(all(all(fitness == 0)))
% 
% figure
% h = histogram(fitness2(:),30)


