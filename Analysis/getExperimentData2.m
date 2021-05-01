function [indexes,metric,data,averageRealFitness,experimentNames,friendlyExperimentNames] = getExperimentData2(experimentNames,friendlyExperimentNames)
%{
    experimentNames = {'20200427 T 192900','20200531 T 153100','20200601 T 184700','20200603 T 085800','20200628 T 131000','20200630 T 093800','20200706 T 224400','20200706 T 123900','20200712 T 120800'};
    friendlyExperimentNames = {'30: SM=3 ME=true','31: SM=3 ME=false','32: SM=1 ME=false','33: SM=1 ME=true','34: SM=2 ME=true','35: SM=2 ME=false','38: SM=1 ME=true','39: SM=3 ME=true','40: SM=3 ME=false'};
%}

if nargin == 0
    experimentNames =  {'76','77','78','79','80','81','82','83','84','85','86','87','88','89'};
    experimentNamesSubFolders =  {'a','b','c','d','e','f','g','h','i','j'};
    friendlyExperimentNames = {'76: SM=1 ME=true','77: SM=2 ME=true%',...
                               '78: SM=3 ME=true HS=10%','79: SM=3 ME=true HS=30%',...
                               '80: SM=3 ME=true HS=50%','81: SM=3 ME=true HS=70%',...
                               '82: SM=3 ME=true HS=90%','83: SM=1 ME=false',...
                               '84: SM=2 ME=false','85: SM=3 ME=false HS=10%',...
                               '86: SM=3 ME=false HS=30%','87: SM=3 ME=false HS=50%',...
                               '86: SM=3 ME=false HS=70%','89: SM=3 ME=false HS=90%'};
end

% bNormaliseFitness = false;
numGenerations = 100;
preallocationColLen = 1000;
dataDir = 'E:\Google Drive\Academics\UCT - MIT\Research\Code\KeepawaySim\Experiment Management\';

% clear indexes{k} metric{k} averageRealFitness averageRealFitnessBoxes data

for k = 1:length(experimentNames)
    for kk = 1:10
    tic
    folderPath = [dataDir experimentNames{k} '\\' experimentNamesSubFolders{kk}];
    
    %% Get XML data
    % plot various metric{k}s for fittest genome (if false -> plot various metric{k}s
    % for that metric{k}s max at each generation
    bTraceBestFitness = true;
    
    indexes{k,kk}.indBestFitness = false(preallocationColLen,numGenerations);
    indexes{k,kk}.indBestRealFitness = false(preallocationColLen,numGenerations);
    indexes{k,kk}.indBestGenotypic_Diversity = false(preallocationColLen,numGenerations);
    indexes{k,kk}.indBestNovelty = false(preallocationColLen,numGenerations);
    indexes{k,kk}.indBestComplexity = false(preallocationColLen,numGenerations);
    indexes{k,kk}.indBestAge = false(preallocationColLen,numGenerations);
    indexes{k,kk}.indBestCycles = false(preallocationColLen,numGenerations);
    indexes{k,kk}.indBestTeamDispersion = false(preallocationColLen,numGenerations);
    indexes{k,kk}.indBestNumPasses = false(preallocationColLen,numGenerations);
    indexes{k,kk}.indBestDistFromCentre = false(preallocationColLen,numGenerations);
    indexes{k,kk}.indBestGenotype_Diversity = false(preallocationColLen,numGenerations);
    indexes{k,kk}.indBestNearestNeighbors = false(preallocationColLen,numGenerations);
    
    metric{k,kk}.fitness = nan(preallocationColLen,numGenerations);
    metric{k,kk}.novelty = nan(preallocationColLen,numGenerations);
    metric{k,kk}.realFitness = nan(preallocationColLen,numGenerations);
    metric{k,kk}.genotypic_Diversity = nan(preallocationColLen,numGenerations);
    metric{k,kk}.complexity = nan(preallocationColLen,numGenerations);
    metric{k,kk}.age = nan(preallocationColLen,numGenerations);
    metric{k,kk}.cycles = nan(preallocationColLen,numGenerations);
    metric{k,kk}.teamDispersion = nan(preallocationColLen,numGenerations);
    metric{k,kk}.numPasses = nan(preallocationColLen,numGenerations);
    metric{k,kk}.distFromCentre = nan(preallocationColLen,numGenerations);
    metric{k,kk}.genotype_Diversity = nan(preallocationColLen,numGenerations);
    metric{k,kk}.nearestNeighbors = nan(preallocationColLen,numGenerations);
    
    for n = 1:numGenerations %each file is generations of evolution
        filename = sprintf('%s/Populations/G%04iPop.xml',folderPath,n);
        xDoc = xml2struct(filename);
        for z = 1:length(xDoc.Population.Genomes.NetworkGenome) % k is genomes in population from generation n
            metric{k,kk}.fitness(z,n) = str2double(xDoc.Population.Genomes.NetworkGenome{z}.Attributes.Fitness);
            metric{k,kk}.realFitness(z,n) = str2double(xDoc.Population.Genomes.NetworkGenome{z}.Attributes.RealFitness);
            metric{k,kk}.genotypic_Diversity(z,n) = str2double(xDoc.Population.Genomes.NetworkGenome{z}.Attributes.Genotypic_Diversity);
            metric{k,kk}.novelty(z,n) = str2double(xDoc.Population.Genomes.NetworkGenome{z}.Attributes.Novelty);
            metric{k,kk}.complexity(z,n) = str2double(xDoc.Population.Genomes.NetworkGenome{z}.Attributes.Complexity);
            metric{k,kk}.age(z,n) = str2double(xDoc.Population.Genomes.NetworkGenome{z}.Attributes.Age);
            
            metric{k,kk}.cycles(z,n) = str2double(xDoc.Population.Genomes.NetworkGenome{z}.BehaviorType.bVector.double{1}.Text);
            metric{k,kk}.teamDispersion(z,n) = str2double(xDoc.Population.Genomes.NetworkGenome{z}.BehaviorType.bVector.double{2}.Text);
            metric{k,kk}.numPasses(z,n) = str2double(xDoc.Population.Genomes.NetworkGenome{z}.BehaviorType.bVector.double{3}.Text);
            metric{k,kk}.distFromCentre(z,n) = str2double(xDoc.Population.Genomes.NetworkGenome{z}.BehaviorType.bVector.double{4}.Text);
            
            metric{k,kk}.genotype_Diversity(z,n) = str2double(xDoc.Population.Genomes.NetworkGenome{z}.GenomeDiversity.genotype_Diversity.Text);
            metric{k,kk}.nearestNeighbors(z,n) = str2double(xDoc.Population.Genomes.NetworkGenome{z}.nearestNeighbors.Text);
        end
        % Find best genome in population from each generation
        if bTraceBestFitness
            indexes{k,kk}.indBestFitness(:,n) = getBestInd(metric{k,kk}.fitness(:,n));
            indexes{k,kk}.indBestRealFitness(:,n) = getBestInd(metric{k,kk}.realFitness(:,n));
            indexes{k,kk}.indBestGenotypic_Diversity(:,n) = getBestInd(metric{k,kk}.genotypic_Diversity(:,n));
            indexes{k,kk}.indBestNovelty(:,n) = getBestInd(metric{k,kk}.novelty(:,n));
            indexes{k,kk}.indBestComplexity(:,n) = getBestInd(metric{k,kk}.complexity(:,n));
            indexes{k,kk}.indBestAge(:,n) = getBestInd(metric{k,kk}.age(:,n));
            indexes{k,kk}.indBestCycles(:,n) = getBestInd(metric{k,kk}.cycles(:,n));
            indexes{k,kk}.indBestTeamDispersion(:,n) = getBestInd(metric{k,kk}.teamDispersion(:,n));
            indexes{k,kk}.indBestNumPasses(:,n) = getBestInd(metric{k,kk}.numPasses(:,n));
            indexes{k,kk}.indBestDistFromCentre(:,n) = getBestInd(metric{k,kk}.distFromCentre(:,n));
            indexes{k,kk}.indBestGenotype_Diversity(:,n) = getBestInd(metric{k,kk}.genotype_Diversity(:,n));
            indexes{k,kk}.indBestNearestNeighbors(:,n) = getBestInd(metric{k,kk}.nearestNeighbors(:,n));
        else
            indexes{k,kk}.indBestFitness(:,n) = getBestInd(metric{k,kk}.fitness(:,n));
            indexes{k,kk}.indBestRealFitness(:,n) = getBestInd(metric{k,kk}.fitness(:,n));
            indexes{k,kk}.indBestGenotypic_Diversity(:,n) = getBestInd(metric{k,kk}.fitness(:,n));
            indexes{k,kk}.indBestNovelty(:,n) = getBestInd(metric{k,kk}.fitness(:,n));
            indexes{k,kk}.indBestComplexity(:,n) = getBestInd(metric{k,kk}.fitness(:,n));
            indexes{k,kk}.indBestAge(:,n) = getBestInd(metric{k,kk}.fitness(:,n));
            indexes{k,kk}.indBestCycles(:,n) = getBestInd(metric{k,kk}.fitness(:,n));
            indexes{k,kk}.indBestTeamDispersion(:,n) = getBestInd(metric{k,kk}.fitness(:,n));
            indexes{k,kk}.indBestNumPasses(:,n) = getBestInd(metric{k,kk}.fitness(:,n));
            indexes{k,kk}.indBestDistFromCentre(:,n) = getBestInd(metric{k,kk}.fitness(:,n));
            indexes{k,kk}.indBestGenotype_Diversity(:,n) = getBestInd(metric{k,kk}.fitness(:,n));
            indexes{k,kk}.indBestNearestNeighbors(:,n) = getBestInd(metric{k,kk}.fitness(:,n));
        end
    end
    
    % trim down (after having initialised variables) into dimensions of pop x
    % gen (eg 300 x 100 for population of 300 and 100 generations)
    metric{k,kk}.fitness = metric{k,kk}.fitness(1:z,:);
    metric{k,kk}.realFitness = metric{k,kk}.realFitness(1:z,:);
    metric{k,kk}.genotypic_Diversity = metric{k,kk}.genotypic_Diversity(1:z,:);
    metric{k,kk}.novelty = metric{k,kk}.novelty(1:z,:);
    metric{k,kk}.complexity = metric{k,kk}.complexity(1:z,:);
    metric{k,kk}.age = metric{k,kk}.age(1:z,:);
    metric{k,kk}.cycles = metric{k,kk}.cycles(1:z,:);
    metric{k,kk}.teamDispersion = metric{k,kk}.teamDispersion(1:z,:);
    metric{k,kk}.numPasses = metric{k,kk}.numPasses(1:z,:);
    metric{k,kk}.distFromCentre = metric{k,kk}.distFromCentre(1:z,:);
    metric{k,kk}.genotype_Diversity = metric{k,kk}.genotype_Diversity(1:z,:);
    metric{k,kk}.nearestNeighbors = metric{k,kk}.nearestNeighbors(1:z,:);
    
    indexes{k,kk}.indBestFitness = indexes{k,kk}.indBestFitness(1:z,:);
    indexes{k,kk}.indBestRealFitness = indexes{k,kk}.indBestRealFitness(1:z,:);
    indexes{k,kk}.indBestGenotypic_Diversity = indexes{k,kk}.indBestGenotypic_Diversity(1:z,:);
    indexes{k,kk}.indBestNovelty = indexes{k,kk}.indBestNovelty(1:z,:);
    indexes{k,kk}.indBestComplexity = indexes{k,kk}.indBestComplexity(1:z,:);
    indexes{k,kk}.indBestAge = indexes{k,kk}.indBestAge(1:z,:);
    indexes{k,kk}.indBestCycles = indexes{k,kk}.indBestCycles(1:z,:);
    indexes{k,kk}.indBestTeamDispersion = indexes{k,kk}.indBestTeamDispersion(1:z,:);
    indexes{k,kk}.indBestNumPasses = indexes{k,kk}.indBestNumPasses(1:z,:);
    indexes{k,kk}.indBestDistFromCentre = indexes{k,kk}.indBestDistFromCentre(1:z,:);
    indexes{k,kk}.indBestGenotype_Diversity = indexes{k,kk}.indBestGenotype_Diversity(1:z,:);
    indexes{k,kk}.indBestNearestNeighbors = indexes{k,kk}.indBestNearestNeighbors(1:z,:);
    
    %% Get fitness map data
    data{k,kk} = readFitnessData(folderPath,numGenerations);
      
    averageRealFitness{k,kk} = nan(numGenerations,1);
    
    for n = 1:numGenerations
        data{k,kk}{n}((data{k,kk}{n}(:,3) == 0),3) = NaN;
        averageRealFitness{k,kk}(n) = nanmean(data{k,kk}{n}(:,3));
    end
    toc
    
    end
end
