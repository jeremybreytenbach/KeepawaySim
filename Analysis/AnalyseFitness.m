%% load data
dataDir = 'E:\Google Drive\Academics\UCT - MIT\Research\Code\KeepawaySim\Experiment Management\';

bNormaliseFitness = false;

% folderPath = [dataDir '20200330 T 135000'];
% folderPath = [dataDir '20200401 T 220300'];
% folderPath = [dataDir '20200402 T 234400'];
% folderPath = [dataDir '20200411 T 101800'];
% folderPath = [dataDir '20200411 T 103600'];
% folderPath = [dataDir '20200411 T 144200'];
% folderPath = [dataDir '20200412 T 214200'];
% folderPath = [dataDir '20200413 T 140200'];
% folderPath = [dataDir '20200413 T 194200'];
% numGenerations = 55;
% folderPath = [dataDir '20200413 T 234800'];
% numGenerations = 100;
%
% folderPath = [dataDir '20200427 T 015300'];
% numGenerations = 100;
%
folderPath = [dataDir '20200427 T 192900'];
numGenerations = 100;

data = readFitnessData(folderPath,numGenerations);

%% Choose data to analyse
realFitness = data{numGenerations};

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

if bNormaliseFitness
    normFitness = normalize(realFitness(1:end),'range')*100;
else
    normFitness = realFitness(1:end);
end
normFitness(normFitness==0) = nan;

figure(19)
hold all
scatter3(x(:),y(:),z(:),normFitness*10,normFitness*10,'filled')
xlabel('team dispersion')
ylabel('no passes')
zlabel('dist from centre')
title('Normalised fitness landscape / Map of elites')

thisAxis = gca;
thisAxis.YTick = 5:5:15;
thisAxis.ZTick = 5:5:15;
axis([0 100 0 20 0 20])

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
best = nan(numGenerations,1);
for k = 1:numGenerations
    best(k) = max(max(max(data{k})));
end

figure(20)
hold all
plot(best)
title('Max real fitness in map')
xlabel('Generation')
ylabel('Fitness')

averageRealFitness = nan(numGenerations,1);
averageRealFitnessBoxes = nan(numGenerations,numGenerations);

for k = 1:numGenerations
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