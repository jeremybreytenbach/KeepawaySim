%% load data
dataDir = 'E:\Google Drive\Academics\UCT - MIT\Research\Code\KeepawaySim\Experiment Management\';

% folderPath = [dataDir '20200330 T 135000'];
% folderPath = [dataDir '20200401 T 220300'];
% folderPath = [dataDir '20200402 T 234400'];
% folderPath = [dataDir '20200411 T 101800'];
% folderPath = [dataDir '20200411 T 103600'];
% folderPath = [dataDir '20200411 T 144200'];
% folderPath = [dataDir '20200412 T 214200'];
% folderPath = [dataDir '20200413 T 140200'];
folderPath = [dataDir '20200413 T 194200'];
maxGens = 55;
% folderPath = [dataDir '20200413 T 234800'];
% maxGens = 100;

data = readFitnessData(folderPath,maxGens);

%% Choose data to analyse
realFitness = data{1};

realFitness = real(realFitness);
realFitness(ismissing(realFitness,0)) = nan;

%% basic stats
figure(18)
hold all
histogram(realFitness)
title('Real Fitness histogram')

%% 3d visualisation
[x,y,z] = meshgrid(1:100);

% figure
% scatter3(x(:),y(:),z(:),fitness(1:end))
% title('Fitness landscape / Map of elites')
% xlabel('team dispersion')
% ylabel('no passes')
% zlabel('dist from centre')

normFitness = normalize(realFitness(1:end),'range');
normFitness(normFitness==0) = nan;

figure(19)
hold all
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

%% Plot best fitness over generations
best = nan(maxGens,1);
for k = 1:maxGens
    best(k) = max(max(max(data{k})));
end

figure(20)
hold all
plot(best)
title('Max real fitness in map')
xlabel('Generation')
ylabel('Fitness')

averageRealFitness = nan(maxGens,1);
averageRealFitnessBoxes = nan(maxGens,maxGens);

for k = 1:maxGens
    thisData = data{k};
    thisData(thisData == 0) = NaN;
    averageRealFitness(k) = nanmean(nanmean(nanmean(thisData)));
    averageRealFitnessBoxes(1:100,k) = nanmean(nanmean(thisData));
end
    
figure(21)
hold all
plot(averageRealFitness)
title('Mean real fitness in map')
xlabel('Generation')
ylabel('Real Fitness')

figure(22)
hold all
boxplot(averageRealFitnessBoxes)
title('Mean real fitness in map')
xlabel('Generation')
ylabel('Real Fitness')