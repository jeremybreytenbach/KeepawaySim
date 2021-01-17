%% Run analysis and save data

experimentNames =  {'20210109 T 233400',...
                    '20210110 T 184500',...
                    '20210111 T 100500',...
                    '20210112 T 011300'};
friendlyExperimentNames =  {'72: SM=3 ME=true Ep=10',...
                            '73: SM=3 ME=false Ep=10',...
                            '74: SM=1 ME=true Ep=10',...
                            '75: SM=1 ME=false Ep=10'};

% experimentNames = {'20210110 T 184500'};
% friendlyExperimentNames = {'73: SM=3 ME=false Ep=10'};

[indexes,metric,data,averageRealFitness,experimentNames,friendlyExperimentNames] = getExperimentData(experimentNames,friendlyExperimentNames);

dateNow = datetime('now');
fileName = sprintf('experimentData_%s.mat',datestr(dateNow,'yyyy-mm-dd T HHMMSS'));
save(fileName,'indexes','metric','data','averageRealFitness','experimentNames','friendlyExperimentNames','dateNow')

%% Load Data
loadDataFileName = fileName(1:end-4);
% loadDataFileName = sprintf('experimentData_%s.mat',datestr(dateNow,'yyyy-mm-dd T HHMMSS'));
% load(loadDataFileName)

%%
figure('Name','Best fitness')
hold all
for expNum = 1:length(experimentNames)
    plot(metric{expNum}.fitness(indexes{expNum}.indBestFitness),'DisplayName','fitness')
    xlabel('Generation')
    ylabel('Best fitness in pop at gen')
    title('Best fitness')
end
legend(friendlyExperimentNames)

figure('Name','Average fitness')
hold all
for expNum = 1:length(experimentNames)
    plot(nanmean(metric{expNum}.fitness,1),'DisplayName','fitness')
    xlabel('Generation')
    ylabel('Average fitness in pop at gen')
    title('Average fitness')
end
legend(friendlyExperimentNames)

for expNum = 1:length(experimentNames)
    figure('Name','Fitness Distribution')
    boxplot(metric{expNum}.fitness)
    xlabel('Generation')
    ylabel('Fitness distribution in pop at gen')
    title(sprintf('Fitness Distribution for %s',friendlyExperimentNames{expNum}))
    axis([0 100 0 15])
end

figure('Name','Best realFitness')
hold all
for expNum = 1:length(experimentNames)
    plot(metric{expNum}.realFitness(indexes{expNum}.indBestRealFitness),'DisplayName','realFitness')
    xlabel('Generation')
    ylabel('Best realFitness in pop at gen')
    title('Best realFitness')
end
legend(friendlyExperimentNames)

figure('Name','Average realFitness')
hold all
for expNum = 1:length(experimentNames)
    plot(nanmean(metric{expNum}.realFitness,1),'DisplayName','realFitness')
    xlabel('Generation')
    ylabel('Average realFitness in pop at gen')
    title('Average realFitness')
end
legend(friendlyExperimentNames)

for expNum = 1:length(experimentNames)
    figure('Name','realFitness Distribution')
    boxplot(metric{expNum}.realFitness)
    xlabel('Generation')
    ylabel('realFitness distribution in pop at gen')
    title(sprintf('realFitness Distribution for %s',friendlyExperimentNames{expNum}))
    axis([0 100 0 15])
end

figure('Name','Best teamDispersion')
hold all
for expNum = 1:length(experimentNames)
    plot(metric{expNum}.teamDispersion(indexes{expNum}.indBestTeamDispersion))
    title('Best teamDispersion')
end
legend(friendlyExperimentNames)

figure('Name','teamDispersion for most fit genome')
hold all
for expNum = 1:length(experimentNames)
    plot(metric{expNum}.teamDispersion(indexes{expNum}.indBestFitness))
    title('teamDispersion for most fit genome')
end
legend(friendlyExperimentNames)

figure('Name','Average teamDispersion')
hold all
for expNum = 1:length(experimentNames)
    plot(nanmean(metric{expNum}.teamDispersion,1))
    title('Average teamDispersion')
end
legend(friendlyExperimentNames)

% NumPasses
figure('Name','Best numPasses')
hold all
for expNum = 1:length(experimentNames)
    plot(metric{expNum}.numPasses(indexes{expNum}.indBestNumPasses))
    title('Best numPasses')
end
legend(friendlyExperimentNames)

figure('Name','numPasses for most fit genome')
hold all
for expNum = 1:length(experimentNames)
    plot(metric{expNum}.numPasses(indexes{expNum}.indBestFitness))
    title('numPasses for most fit genome')
end
legend(friendlyExperimentNames)

figure('Name','Average numPasses')
hold all
for expNum = 1:length(experimentNames)
    plot(nanmean(metric{expNum}.numPasses,1))
    title('Average numPasses')
end
legend(friendlyExperimentNames)

% distFromCentre
figure('Name','Best distFromCentre')
hold all
for expNum = 1:length(experimentNames)
    plot(metric{expNum}.distFromCentre(indexes{expNum}.indBestDistFromCentre))
    title('Best distFromCentre')
end
legend(friendlyExperimentNames)

figure('Name','distFromCentre for most fit genome')
hold all
for expNum = 1:length(experimentNames)
    plot(metric{expNum}.distFromCentre(indexes{expNum}.indBestFitness))
    title('distFromCentre for most fit genome')
end
legend(friendlyExperimentNames)

figure('Name','Average distFromCentre')
hold all
for expNum = 1:length(experimentNames)
    plot(nanmean(metric{expNum}.distFromCentre,1))
    title('Average distFromCentre')
end
legend(friendlyExperimentNames)

% age
figure('Name','age for most fit genome')
hold all
for expNum = 1:length(experimentNames)
    plot(metric{expNum}.age(indexes{expNum}.indBestFitness))
    title('age for most fit genome')
end
legend(friendlyExperimentNames)

figure('Name','Average age')
hold all
for expNum = 1:length(experimentNames)
    plot(nanmean(metric{expNum}.age,1))
    title('Average age')
end
legend(friendlyExperimentNames)

figure('Name','Age')
hold all
for expNum = 1:length(experimentNames)
    boxplot(metric{expNum}.age)
    title('Age')
end
legend(friendlyExperimentNames)

figure('Name','metrics for best genome over generations')
hold all
for expNum = 1:length(experimentNames)
    plot(normalize(horzcat(metric{expNum}.fitness(indexes{expNum}.indBestFitness),metric{expNum}.cycles(indexes{expNum}.indBestCycles),...
        metric{expNum}.teamDispersion(indexes{expNum}.indBestTeamDispersion),metric{expNum}.numPasses(indexes{expNum}.indBestNumPasses),metric{expNum}.distFromCentre(indexes{expNum}.indBestDistFromCentre))))
    title('metrics for best genome over generations')
    legend('fitness','cycles/realFitness','teamDispersion','numPasses','distFromCentre')
end

figure('Name','Real Fitness histograms')
n = 0;
for expNum = 1:length(experimentNames)
    n = n+1;
    subplot(2,2,n)
    histogram(data{expNum}{end}(:,4))
    title(sprintf('Real Fitness histogram\n%s',friendlyExperimentNames{expNum}))
    axis([0 15 0 1800])
end

figure('Name','Fitness histograms')
n = 0;
for expNum = 1:length(experimentNames)
    n = n+1;
    subplot(2,2,n)
    histogram(data{expNum}{end}(:,5))
    title(sprintf('Fitness histogram\n%s',friendlyExperimentNames{expNum}))
    axis([0 15 0 1500])
end

thisLim = 100; % thisLim = [200 2000 100];
for kz = 1:length(thisLim)
    figure('Name','Normalised fitness landscape - Map of elites')
    % hold all
    scaler = ones(1,length(experimentNames));
    n = 0;
    clear thisAxis
    for expNum = 1:length(experimentNames)
        try
            n = n+1;
            subplot(2,2,n)
            scatter3(data{expNum}{end}(:,1)./10,data{expNum}{end}(:,2)./10,data{expNum}{end}(:,3)./10,...
                data{expNum}{end}(:,4).*scaler(n),data{expNum}{end}(:,4).*scaler(n),'filled')
            %         scatter3(data{expNum}{end}(:,1)./10,data{expNum}{end}(:,2)./10,data{expNum}{end}(:,3)./10,...
            %             1,data{expNum}{end}(:,4).*scaler(n),'filled')
            xlabel('team dispersion')
            ylabel('no passes')
            zlabel('dist from centre')
            title(sprintf(['Normalised fitness landscape / Map of elites\n' friendlyExperimentNames{expNum}]))
            thisAxis(n) = gca;
            grid on
            colormap(jet);
            caxis manual
            caxis([0 max(data{n}{end}(:,4))]);
            colorbar;
            axis([6 14 0 thisLim(kz) 6 14])
        catch
        end
    end
    thisLink{n} = linkprop(thisAxis,{'CameraUpVector', 'CameraPosition', 'CameraTarget', 'XLim', 'YLim', 'ZLim'});
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

figure('Name','Mean real fitness in map')
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
    figure('Name','Real fitness in map')   
    boxplotData = nan(length(data{end}{end}),100);
    for k = 1:length(data{expNum})
        boxplotData(1:length(data{expNum}{k}(:,4)),k) = data{expNum}{k}(:,4);
    end  
    boxplot(boxplotData)
    title(sprintf(['Real fitness in map\n' friendlyExperimentNames{expNum}]))
    xlabel('Generation')
    ylabel('Real Fitness')
end

n = 0;
for expNum = 1:length(experimentNames)
    n = n+1;
    figure('Name','Fitness in map')   
    boxplotData = nan(length(data{end}{end}),100);
    for k = 1:length(data{expNum})
        boxplotData(1:length(data{expNum}{k}(:,5)),k) = data{expNum}{k}(:,5);
    end  
    boxplot(boxplotData)
    title(sprintf(['Fitness in map\n' friendlyExperimentNames{expNum}]))
    xlabel('Generation')
    ylabel('Fitness')
end

figure('Name','Number of unique elites')
bar([length(data{1}{end}),length(data{2}{end}),length(data{3}{end})...
    length(data{4}{end})]);%,...
    %length(data{6}{end}),length(data{7}{end}),length(data{8}{end})]);
title('Number of unique elites')
ax = gca;
ax.XTick = 1:length(friendlyExperimentNames);
ax.XTickLabel = friendlyExperimentNames;
ax.XTickLabelRotation = 45;

figure('Name','Max real fitness at gen')
for expNum = 1:length(experimentNames)
    for k = 1:100
        maxRealFitnessAtGen(k,1) = max(data{expNum}{k}(:,4));
    end
    plot(maxRealFitnessAtGen)
    hold on
end
title('Max real fitness at gen')
xlabel('Generation')
ylabel('Real Fitness')
legend(friendlyExperimentNames)
ylim([0 15])

figure('Name','Max fitness at gen')
for expNum = 1:length(experimentNames)
    for k = 1:100
        maxFitnessAtGen(k,1) = max(data{expNum}{k}(:,5));
    end
    plot(maxFitnessAtGen)
    hold on
end
title('Max fitness at gen')
xlabel('Generation')
ylabel('Fitness')
legend(friendlyExperimentNames)
ylim([0 15])

% data
% figure('Name','Max fitness in map at each generation')
% hold all
% for kn = 1:length(experimentNames)
%     for k = 1:length(data{kn})
%         [M,I] = max(data{kn}{k}(:,4));
%         maxFitnessInMap(k,kn) = M;
%     end
%     plot(maxFitnessInMap(:,kn))
%     title('Max fitness in map at each generation')
%     xlabel('Generation')
%     ylabel('Real Fitness')
% end
% legend(friendlyExperimentNames)

[globalFitness,coverage,globalReliability,summaryData] = getMapEliteMetrics(data,experimentNames);

figure('Name','Global Fitness')
bar(globalFitness*100)
title('Global Fitness')
xlabel('Experiment')
ylabel('%')
ax = gca;
ax.XTick = 1:length(friendlyExperimentNames);
ax.XTickLabel = friendlyExperimentNames;
ax.XTickLabelRotation = 45;

figure('Name','Coverage')
bar(coverage*100)
title('Coverage')
xlabel('Experiment')
ylabel('%')
ax = gca;
ax.XTick = 1:length(friendlyExperimentNames);
ax.XTickLabel = friendlyExperimentNames;
ax.XTickLabelRotation = 45;

figure('Name','Global Reliability')
bar(globalReliability*100)
title('Global Reliability')
xlabel('Experiment')
ylabel('%')
ax = gca;
ax.XTick = 1:length(friendlyExperimentNames);
ax.XTickLabel = friendlyExperimentNames;
ax.XTickLabelRotation = 45;

figure('Name',sprintf('Sparsity of Best Solution at each Generation'))
for expNum = 1:length(friendlyExperimentNames)    
    subplot(1,length(friendlyExperimentNames),expNum)
    spy(indexes{expNum}.indBestFitness,10);
    title(sprintf('Sparsity for %s', friendlyExperimentNames{expNum}))
end

%% Save all figures
figObjs =  findobj('type','figure');
numFigs = length(figObjs);

mkdir(loadDataFileName);

for k = 1:numFigs
    thisFig = figure(k);
    savefig(thisFig,sprintf('%s/Figure %i - %s',loadDataFileName,k,thisFig.Name))
end





