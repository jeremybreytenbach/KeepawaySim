[indexes,metric,realFitness,normFitness,best,eliteMap,...
    experimentNames,averageRealFitness,averageRealFitnessBoxes] = getExperimentData();

% dateNow = datetime('now');
% save('experimentData.mat','indexes','metric','realFitness','normFitness','best','eliteMap','averageRealFitness','averageRealFitnessBoxes','experimentNames','dateNow')
% load('experimentData.mat')

%%
friendlyExperimentNames = {'30: SM=3 ME=true','31: SM=3 ME=false','32: SM=1 ME=false','33: SM=1 ME=true','34: SM=2 ME=true','35: SM=2 ME=false'};

figure(1)
hold all
for expNum = 1:length(experimentNames)
    plot(metric{expNum}.fitness(indexes{expNum}.indBestFitness),'DisplayName','fitness')
    xlabel('Generation')
    ylabel('Best fitness in pop at gen')
    title('Best fitness')
end
legend(friendlyExperimentNames)

figure(2)
hold all
for expNum = 1:length(experimentNames)
    plot(nanmean(metric{expNum}.fitness,1),'DisplayName','fitness')
    xlabel('Generation')
    ylabel('Average fitness in pop at gen')
    title('Average fitness')
end
legend(friendlyExperimentNames)

figure(3)
hold all
for expNum = 1:length(experimentNames)
    plot(metric{expNum}.realFitness(indexes{expNum}.indBestRealFitness),'DisplayName','realFitness')
    xlabel('Generation')
    ylabel('Best realFitness in pop at gen')
    title('Best realFitness')
end
legend(friendlyExperimentNames)

figure(4)
hold all
for expNum = 1:length(experimentNames)
    plot(nanmean(metric{expNum}.realFitness,1),'DisplayName','realFitness')
    xlabel('Generation')
    ylabel('Average realFitness in pop at gen')
    title('Average realFitness')
end
legend(friendlyExperimentNames)

figure(5)
hold all
for expNum = 1:length(experimentNames)
    plot(metric{expNum}.teamDispersion(indexes{expNum}.indBestTeamDispersion))
    title('Best teamDispersion')
end
legend(friendlyExperimentNames)

figure(6)
hold all
for expNum = 1:length(experimentNames)
    plot(metric{expNum}.teamDispersion(indexes{expNum}.indBestFitness))
    title('teamDispersion for most fit genome')
end
legend(friendlyExperimentNames)

figure(7)
hold all
for expNum = 1:length(experimentNames)
    plot(nanmean(metric{expNum}.teamDispersion,1))
    title('Average teamDispersion')
end
legend(friendlyExperimentNames)

% NumPasses
figure(8)
hold all
for expNum = 1:length(experimentNames)
    plot(metric{expNum}.numPasses(indexes{expNum}.indBestNumPasses))
    title('Best numPasses')
end
legend(friendlyExperimentNames)

figure(9)
hold all
for expNum = 1:length(experimentNames)
    plot(metric{expNum}.numPasses(indexes{expNum}.indBestFitness))
    title('numPasses for most fit genome')
end
legend(friendlyExperimentNames)

figure(10)
hold all
for expNum = 1:length(experimentNames)
    plot(nanmean(metric{expNum}.numPasses,1))
    title('Average numPasses')
end
legend(friendlyExperimentNames)

% distFromCentre
figure(11)
hold all
for expNum = 1:length(experimentNames)
    plot(metric{expNum}.distFromCentre(indexes{expNum}.indBestDistFromCentre))
    title('Best distFromCentre')
end
legend(friendlyExperimentNames)

figure(12)
hold all
for expNum = 1:length(experimentNames)
    plot(metric{expNum}.distFromCentre(indexes{expNum}.indBestFitness))
    title('distFromCentre for most fit genome')
end
legend(friendlyExperimentNames)

figure(13)
hold all
for expNum = 1:length(experimentNames)
    plot(nanmean(metric{expNum}.distFromCentre,1))
    title('Average distFromCentre')
end
legend(friendlyExperimentNames)

% age
figure(14)
hold all
for expNum = 1:length(experimentNames)
    plot(metric{expNum}.age(indexes{expNum}.indBestFitness))
    title('age for most fit genome')
end
legend(friendlyExperimentNames)

figure(15)
hold all
for expNum = 1:length(experimentNames)
    plot(nanmean(metric{expNum}.age,1))
    title('Average age')
end
legend(friendlyExperimentNames)

figure(16)
hold all
for expNum = 1:length(experimentNames)
    boxplot(metric{expNum}.age)
    title('Age')
end
legend(friendlyExperimentNames)

figure(17)
hold all
for expNum = 1:length(experimentNames)
    plot(normalize(horzcat(metric{expNum}.fitness(indexes{expNum}.indBestFitness),metric{expNum}.cycles(indexes{expNum}.indBestCycles),...
        metric{expNum}.teamDispersion(indexes{expNum}.indBestTeamDispersion),metric{expNum}.numPasses(indexes{expNum}.indBestNumPasses),metric{expNum}.distFromCentre(indexes{expNum}.indBestDistFromCentre))))
    title('metrics for best genome over generations')
    legend('fitness','cycles/realFitness','teamDispersion','numPasses','distFromCentre')
end

figure(18)
hold all
for expNum = 1:length(experimentNames)
    histogram(realFitness{expNum})
    title('Real Fitness histogram')
end
legend(friendlyExperimentNames)

figure(19)
% hold all
n = 0;
for expNum = [1,2,4,5,6]
    n = n+1;
    subplot(2,3,n)
    scatter3(eliteMap{expNum}.X(:),eliteMap{expNum}.Y(:),eliteMap{expNum}.z(:),normFitness{expNum}(1:1e6)'*10,normFitness{expNum}(1:1e6)'*10,'filled')
    xlabel('team dispersion')
    ylabel('no passes')
    zlabel('dist from centre')
    title(sprintf(['Normalised fitness landscape / Map of elites\n' friendlyExperimentNames{expNum}]))
    thisAxis = gca;
    thisAxis.YTick = 5:5:15;
    thisAxis.ZTick = 5:5:15;
    axis([0 100 0 20 0 20])
    grid on
    colormap(jet);
    colorbar;
end

figure(20)
hold all
for expNum = 1:length(experimentNames)
    plot(best{expNum})
    title('Max real fitness in map')
    xlabel('Generation')
    ylabel('Fitness')
end
legend(friendlyExperimentNames)

figure(21)
hold all
for expNum = 1:length(experimentNames)
    plot(averageRealFitness{expNum})
    title('Mean real fitness in map')
    xlabel('Generation')
    ylabel('Real Fitness')
end
legend(friendlyExperimentNames)

n = 0;
for expNum = 1:length(experimentNames)
    n = n+1;
    figure(21+n)
    boxplot(averageRealFitnessBoxes{expNum})
    title(sprintf(['Mean real fitness in map\n' friendlyExperimentNames{expNum}]))
    xlabel('Generation')
    ylabel('Real Fitness')
end

figure(27)
bar([nnz(~isnan(normFitness{1})),nnz(~isnan(normFitness{2})),...
    nnz(~isnan(normFitness{3})),nnz(~isnan(normFitness{4})),nnz(~isnan(normFitness{5})),...
    nnz(~isnan(normFitness{6}))]);
title('Number of unique elites')
ax = gca;
ax.XTickLabel = friendlyExperimentNames;