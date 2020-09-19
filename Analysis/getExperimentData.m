function [indexes,metric,data,averageRealFitness,experimentNames,friendlyExperimentNames] = getExperimentData(experimentNames,friendlyExperimentNames)

if nargin == 0
    experimentNames = {'20200427 T 192900','20200531 T 153100','20200601 T 184700','20200603 T 085800','20200628 T 131000','20200630 T 093800','20200706 T 224400','20200706 T 123900','20200712 T 120800'};
    friendlyExperimentNames = {'30: SM=3 ME=true','31: SM=3 ME=false','32: SM=1 ME=false','33: SM=1 ME=true','34: SM=2 ME=true','35: SM=2 ME=false','38: SM=1 ME=true','39: SM=3 ME=true','40: SM=3 ME=false'};
end

% bNormaliseFitness = false;
numGenerations = 100;
preallocationColLen = 1000;
dataDir = 'E:\Google Drive\Academics\UCT - MIT\Research\Code\KeepawaySim\Experiment Management\';

% clear indexes{k} metric{k} averageRealFitness averageRealFitnessBoxes data

for k = 1:length(experimentNames)
    tic
    folderPath = [dataDir experimentNames{k}];
    
    %% Get XML data
    % plot various metric{k}s for fittest genome (if false -> plot various metric{k}s
    % for that metric{k}s max at each generation
    bTraceBestFitness = true;
    
    indexes{k}.indBestFitness = false(preallocationColLen,numGenerations);
    indexes{k}.indBestRealFitness = false(preallocationColLen,numGenerations);
    indexes{k}.indBestGenotypic_Diversity = false(preallocationColLen,numGenerations);
    indexes{k}.indBestNovelty = false(preallocationColLen,numGenerations);
    indexes{k}.indBestComplexity = false(preallocationColLen,numGenerations);
    indexes{k}.indBestAge = false(preallocationColLen,numGenerations);
    indexes{k}.indBestCycles = false(preallocationColLen,numGenerations);
    indexes{k}.indBestTeamDispersion = false(preallocationColLen,numGenerations);
    indexes{k}.indBestNumPasses = false(preallocationColLen,numGenerations);
    indexes{k}.indBestDistFromCentre = false(preallocationColLen,numGenerations);
    indexes{k}.indBestGenotype_Diversity = false(preallocationColLen,numGenerations);
    indexes{k}.indBestNearestNeighbors = false(preallocationColLen,numGenerations);
    
    metric{k}.fitness = nan(preallocationColLen,numGenerations);
    metric{k}.novelty = nan(preallocationColLen,numGenerations);
    metric{k}.realFitness = nan(preallocationColLen,numGenerations);
    metric{k}.genotypic_Diversity = nan(preallocationColLen,numGenerations);
    metric{k}.complexity = nan(preallocationColLen,numGenerations);
    metric{k}.age = nan(preallocationColLen,numGenerations);
    metric{k}.cycles = nan(preallocationColLen,numGenerations);
    metric{k}.teamDispersion = nan(preallocationColLen,numGenerations);
    metric{k}.numPasses = nan(preallocationColLen,numGenerations);
    metric{k}.distFromCentre = nan(preallocationColLen,numGenerations);
    metric{k}.genotype_Diversity = nan(preallocationColLen,numGenerations);
    metric{k}.nearestNeighbors = nan(preallocationColLen,numGenerations);
    
    for n = 1:numGenerations %each file is generations of evolution
        filename = sprintf('%s/Populations/G%04iPop.xml',folderPath,n);
        xDoc = xml2struct(filename);
        for z = 1:length(xDoc.Population.Genomes.NetworkGenome) % k is genomes in population from generation n
            metric{k}.fitness(z,n) = str2double(xDoc.Population.Genomes.NetworkGenome{z}.Attributes.Fitness);
            metric{k}.realFitness(z,n) = str2double(xDoc.Population.Genomes.NetworkGenome{z}.Attributes.RealFitness);
            metric{k}.genotypic_Diversity(z,n) = str2double(xDoc.Population.Genomes.NetworkGenome{z}.Attributes.Genotypic_Diversity);
            metric{k}.novelty(z,n) = str2double(xDoc.Population.Genomes.NetworkGenome{z}.Attributes.Novelty);
            metric{k}.complexity(z,n) = str2double(xDoc.Population.Genomes.NetworkGenome{z}.Attributes.Complexity);
            metric{k}.age(z,n) = str2double(xDoc.Population.Genomes.NetworkGenome{z}.Attributes.Age);
            
            metric{k}.cycles(z,n) = str2double(xDoc.Population.Genomes.NetworkGenome{z}.BehaviorType.bVector.double{1}.Text);
            metric{k}.teamDispersion(z,n) = str2double(xDoc.Population.Genomes.NetworkGenome{z}.BehaviorType.bVector.double{2}.Text);
            metric{k}.numPasses(z,n) = str2double(xDoc.Population.Genomes.NetworkGenome{z}.BehaviorType.bVector.double{3}.Text);
            metric{k}.distFromCentre(z,n) = str2double(xDoc.Population.Genomes.NetworkGenome{z}.BehaviorType.bVector.double{4}.Text);
            
            metric{k}.genotype_Diversity(z,n) = str2double(xDoc.Population.Genomes.NetworkGenome{z}.GenomeDiversity.genotype_Diversity.Text);
            metric{k}.nearestNeighbors(z,n) = str2double(xDoc.Population.Genomes.NetworkGenome{z}.nearestNeighbors.Text);
        end
        % Find best genome in population from each generation
        if bTraceBestFitness
            indexes{k}.indBestFitness(:,n) = getBestInd(metric{k}.fitness(:,n));
            indexes{k}.indBestRealFitness(:,n) = getBestInd(metric{k}.realFitness(:,n));
            indexes{k}.indBestGenotypic_Diversity(:,n) = getBestInd(metric{k}.genotypic_Diversity(:,n));
            indexes{k}.indBestNovelty(:,n) = getBestInd(metric{k}.novelty(:,n));
            indexes{k}.indBestComplexity(:,n) = getBestInd(metric{k}.complexity(:,n));
            indexes{k}.indBestAge(:,n) = getBestInd(metric{k}.age(:,n));
            indexes{k}.indBestCycles(:,n) = getBestInd(metric{k}.cycles(:,n));
            indexes{k}.indBestTeamDispersion(:,n) = getBestInd(metric{k}.teamDispersion(:,n));
            indexes{k}.indBestNumPasses(:,n) = getBestInd(metric{k}.numPasses(:,n));
            indexes{k}.indBestDistFromCentre(:,n) = getBestInd(metric{k}.distFromCentre(:,n));
            indexes{k}.indBestGenotype_Diversity(:,n) = getBestInd(metric{k}.genotype_Diversity(:,n));
            indexes{k}.indBestNearestNeighbors(:,n) = getBestInd(metric{k}.nearestNeighbors(:,n));
        else
            indexes{k}.indBestFitness(:,n) = getBestInd(metric{k}.fitness(:,n));
            indexes{k}.indBestRealFitness(:,n) = getBestInd(metric{k}.fitness(:,n));
            indexes{k}.indBestGenotypic_Diversity(:,n) = getBestInd(metric{k}.fitness(:,n));
            indexes{k}.indBestNovelty(:,n) = getBestInd(metric{k}.fitness(:,n));
            indexes{k}.indBestComplexity(:,n) = getBestInd(metric{k}.fitness(:,n));
            indexes{k}.indBestAge(:,n) = getBestInd(metric{k}.fitness(:,n));
            indexes{k}.indBestCycles(:,n) = getBestInd(metric{k}.fitness(:,n));
            indexes{k}.indBestTeamDispersion(:,n) = getBestInd(metric{k}.fitness(:,n));
            indexes{k}.indBestNumPasses(:,n) = getBestInd(metric{k}.fitness(:,n));
            indexes{k}.indBestDistFromCentre(:,n) = getBestInd(metric{k}.fitness(:,n));
            indexes{k}.indBestGenotype_Diversity(:,n) = getBestInd(metric{k}.fitness(:,n));
            indexes{k}.indBestNearestNeighbors(:,n) = getBestInd(metric{k}.fitness(:,n));
        end
    end
    
    % trim down (after having initialised variables) into dimensions of pop x
    % gen (eg 300 x 100 for population of 300 and 100 generations)
    metric{k}.fitness = metric{k}.fitness(1:z,:);
    metric{k}.realFitness = metric{k}.realFitness(1:z,:);
    metric{k}.genotypic_Diversity = metric{k}.genotypic_Diversity(1:z,:);
    metric{k}.novelty = metric{k}.novelty(1:z,:);
    metric{k}.complexity = metric{k}.complexity(1:z,:);
    metric{k}.age = metric{k}.age(1:z,:);
    metric{k}.cycles = metric{k}.cycles(1:z,:);
    metric{k}.teamDispersion = metric{k}.teamDispersion(1:z,:);
    metric{k}.numPasses = metric{k}.numPasses(1:z,:);
    metric{k}.distFromCentre = metric{k}.distFromCentre(1:z,:);
    metric{k}.genotype_Diversity = metric{k}.genotype_Diversity(1:z,:);
    metric{k}.nearestNeighbors = metric{k}.nearestNeighbors(1:z,:);
    
    indexes{k}.indBestFitness = indexes{k}.indBestFitness(1:z,:);
    indexes{k}.indBestRealFitness = indexes{k}.indBestRealFitness(1:z,:);
    indexes{k}.indBestGenotypic_Diversity = indexes{k}.indBestGenotypic_Diversity(1:z,:);
    indexes{k}.indBestNovelty = indexes{k}.indBestNovelty(1:z,:);
    indexes{k}.indBestComplexity = indexes{k}.indBestComplexity(1:z,:);
    indexes{k}.indBestAge = indexes{k}.indBestAge(1:z,:);
    indexes{k}.indBestCycles = indexes{k}.indBestCycles(1:z,:);
    indexes{k}.indBestTeamDispersion = indexes{k}.indBestTeamDispersion(1:z,:);
    indexes{k}.indBestNumPasses = indexes{k}.indBestNumPasses(1:z,:);
    indexes{k}.indBestDistFromCentre = indexes{k}.indBestDistFromCentre(1:z,:);
    indexes{k}.indBestGenotype_Diversity = indexes{k}.indBestGenotype_Diversity(1:z,:);
    indexes{k}.indBestNearestNeighbors = indexes{k}.indBestNearestNeighbors(1:z,:);
    
    %% Get fitness map data
    data{k} = readFitnessData(folderPath,numGenerations);
    
    % Choose data to analyse
%     realFitness = data{numGenerations};
%     realFitness = real(realFitness);
%     realFitness(ismissing(realFitness,0)) = nan;
    
%     [eliteMap.X,eliteMap.Y,eliteMap.z] = meshgrid(1:numGenerations);
    
%     if bNormaliseFitness
%         normFitness = normalize(realFitness(1:end),'range')*numGenerations;
%     else
%         normFitness = realFitness(1:end);
%     end
%     normFitness(normFitness == 0) = nan;
    
%     best = nan(numGenerations,1);
%     for z = 1:numGenerations
%         best(z) = max(max(max(data{z})));
%     end
    
    averageRealFitness{k} = nan(numGenerations,1);
%     averageRealFitnessBoxes = nan(numGenerations,numGenerations);
    
    for n = 1:numGenerations
        data{k}{n}((data{k}{n}(:,3) == 0),3) = NaN;
        averageRealFitness{k}(n) = nanmean(data{k}{n}(:,3));
%         averageRealFitnessBoxes(1:100,n) = data{n}(:,3);
    end
    toc
    
    %% Save data
%     disp('Saving data...')
%     tic
%     dateNow = datetime('now');
%     saveFileName = sprintf('experimentData_%s.mat',experimentNames{k});
%     save(saveFileName,'indexes{k}','metric{k}','averageRealFitness','averageRealFitnessBoxes','experimentNames','dateNow')
%     fprintf('Saved data: ''%s''\n',saveFileName)
%     toc
end
