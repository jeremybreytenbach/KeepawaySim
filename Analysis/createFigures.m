experimentNames = {'20200706 T 224400','20200706 T 123900','20200712 T 120800','20200806 T 214500'};
friendlyExperimentNames = {'38: SM=1 ME=true','39: SM=3 ME=true','40: SM=3 ME=false','45: SM=3 ME=true'};

% experimentNames = {'20200712 T 120800'};
% friendlyExperimentNames = {'40: SM=3 ME=false'};

[indexes,metric,data,averageRealFitness,experimentNames,friendlyExperimentNames] = getExperimentData(experimentNames,friendlyExperimentNames);

dateNow = datetime('now');
save(sprintf('experimentData_%s.mat',datestr(dateNow,'yyyy-mm-dd T HHMMSS')),'indexes','metric','data','averageRealFitness','experimentNames','friendlyExperimentNames','dateNow')
% load('experimentData.mat')

%%

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

%%

% figure(18)
% hold all
figure
n = 0;
for expNum = 1:length(experimentNames)
    n = n+1;
%     figure(17+n)
    subplot(2,2,n)
    histogram(data{expNum}{end}(:,4))
    title(sprintf('Real Fitness histogram\n%s',friendlyExperimentNames{expNum}))
end
% legend(friendlyExperimentNames)

figure
% hold all
n = 0;
for expNum = 1:length(experimentNames)
    try
        n = n+1;
        subplot(2,2,n)
        scatter3(data{expNum}{end}(:,1)./100,data{expNum}{end}(:,2)./100,data{expNum}{end}(:,3)./100,...
            data{expNum}{end}(:,4)*1,data{expNum}{end}(:,4)*10,'filled')
        xlabel('team dispersion')
        ylabel('no passes')
        zlabel('dist from centre')
        title(sprintf(['Normalised fitness landscape / Map of elites\n' friendlyExperimentNames{expNum}]))
%       thisAxis = gca;
%       thisAxis.YTick = 5:5:15;
%       thisAxis.ZTick = 5:5:15;
%       axis([0 100 0 20 0 20])
        grid on
        colormap(jet);
        colorbar;
    catch
    end
end

% figure(20)
% hold all
% for expNum = 1:length(experimentNames)
%     plot(best{expNum})
%     title('Max real fitness in map')
%     xlabel('Generation')
%     ylabel('Fitness')
% end
% legend(friendlyExperimentNames)

figure
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
    figure%(20+n)    
    boxplotData = nan(length(data{end}{end}),100);
    for k = 1:length(data{expNum})
        boxplotData(1:length(data{expNum}{k}(:,4)),k) = data{expNum}{k}(:,4);
    end  
    boxplot(boxplotData)
    title(sprintf(['Real fitness in map\n' friendlyExperimentNames{expNum}]))
    xlabel('Generation')
    ylabel('Real Fitness')
end

figure
bar([length(data{1}{end}),length(data{2}{end}),length(data{3}{end})])%,...
%     length(data{4}{end}),length(data{5}{end}),...
%     length(data{6}{end}),length(data{7}{end}),length(data{8}{end})]);
title('Number of unique elites')
ax = gca;
ax.XTickLabel = friendlyExperimentNames;
ax.XTickLabelRotation = 45;

figure
for expNum = 1:length(experimentNames)
    for k = 1:100
        maxMeanRealFitnessAtGen(k,1) = max(data{expNum}{k}(:,4));
    end
    plot(maxMeanRealFitnessAtGen)
    hold on
end
title('Max mean real fitness at gen')
xlabel('Generation')
ylabel('Real Fitness')
legend(friendlyExperimentNames)
axis([0 100 0 20])