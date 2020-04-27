%{
fitness = Task performance, number of timesteps
novelty = Measure of novelty (how different is this genome from the others)
realFitness = ?
genotypic_Diversity = ?
complexity = Complexity of the genome (how complex is the CPPN)
age = How many generations has this genome lasted
cycles = ?
teamDispersion = 
numPasses = 
distFromCentre = 
genotype_Diversity = 
nearestNeighbors = 
%}

% TODO: Add complexity and efficiency
preallocationColLen = 500;
% dataDir = 'E:/Google Drive/Academics/UCT - MIT/Research/Code/KeepawaySim/HyperNEAT Keepaway/Sources/KeepAway/bin/Debug/';

dataDir = 'E:\Google Drive\Academics\UCT - MIT\Research\Code\KeepawaySim\Experiment Management\';

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
folderPath = [dataDir '20200427 T 015300'];
numGenerations = 100;

% plot various metrics for fittest genome (if false -> plot various metrics
% for that metrics max at each generation
bTraceBestFitness = true;

indBestFitness = false(preallocationColLen,numGenerations);
indBestRealFitness = false(preallocationColLen,numGenerations);
indBestGenotypic_Diversity = false(preallocationColLen,numGenerations);
indBestNovelty = false(preallocationColLen,numGenerations);
indBestComplexity = false(preallocationColLen,numGenerations);
indBestAge = false(preallocationColLen,numGenerations);
indBestCycles = false(preallocationColLen,numGenerations);
indBestTeamDispersion = false(preallocationColLen,numGenerations);
indBestNumPasses = false(preallocationColLen,numGenerations);
indBestDistFromCentre = false(preallocationColLen,numGenerations);
indBestGenotype_Diversity = false(preallocationColLen,numGenerations);
indBestNearestNeighbors = false(preallocationColLen,numGenerations);

fitness = nan(preallocationColLen,numGenerations);
novelty = nan(preallocationColLen,numGenerations);
realFitness = nan(preallocationColLen,numGenerations);
genotypic_Diversity = nan(preallocationColLen,numGenerations);
complexity = nan(preallocationColLen,numGenerations);
age = nan(preallocationColLen,numGenerations);
cycles = nan(preallocationColLen,numGenerations);
teamDispersion = nan(preallocationColLen,numGenerations);
numPasses = nan(preallocationColLen,numGenerations);
distFromCentre = nan(preallocationColLen,numGenerations);
genotype_Diversity = nan(preallocationColLen,numGenerations);
nearestNeighbors = nan(preallocationColLen,numGenerations);

for n = 1:numGenerations %each file is generations of evolution
    filename = sprintf('%s/Populations/G%04iPop.xml',folderPath,n);
    xDoc = xml2struct(filename);
    for k = 1:length(xDoc.Population.Genomes.NetworkGenome) % k is genomes in population from generation n
        fitness(k,n) = str2double(xDoc.Population.Genomes.NetworkGenome{k}.Attributes.Fitness);
        realFitness(k,n) = str2double(xDoc.Population.Genomes.NetworkGenome{k}.Attributes.RealFitness);
        genotypic_Diversity(k,n) = str2double(xDoc.Population.Genomes.NetworkGenome{k}.Attributes.Genotypic_Diversity);
        novelty(k,n) = str2double(xDoc.Population.Genomes.NetworkGenome{k}.Attributes.Novelty);
        complexity(k,n) = str2double(xDoc.Population.Genomes.NetworkGenome{k}.Attributes.Complexity);
        age(k,n) = str2double(xDoc.Population.Genomes.NetworkGenome{k}.Attributes.Age);
        
        cycles(k,n) = str2double(xDoc.Population.Genomes.NetworkGenome{k}.BehaviorType.bVector.double{1}.Text);
        teamDispersion(k,n) = str2double(xDoc.Population.Genomes.NetworkGenome{k}.BehaviorType.bVector.double{2}.Text);
        numPasses(k,n) = str2double(xDoc.Population.Genomes.NetworkGenome{k}.BehaviorType.bVector.double{3}.Text);
        distFromCentre(k,n) = str2double(xDoc.Population.Genomes.NetworkGenome{k}.BehaviorType.bVector.double{4}.Text);
        
        genotype_Diversity(k,n) = str2double(xDoc.Population.Genomes.NetworkGenome{k}.GenomeDiversity.genotype_Diversity.Text);
        nearestNeighbors(k,n) = str2double(xDoc.Population.Genomes.NetworkGenome{k}.nearestNeighbors.Text);
    end    
    % Find best genome in population from each generation
    if bTraceBestFitness
        indBestFitness(:,n) = getBestInd(fitness(:,n));
        indBestRealFitness(:,n) = getBestInd(realFitness(:,n));
        indBestGenotypic_Diversity(:,n) = getBestInd(genotypic_Diversity(:,n));
        indBestNovelty(:,n) = getBestInd(novelty(:,n));
        indBestComplexity(:,n) = getBestInd(complexity(:,n));
        indBestAge(:,n) = getBestInd(age(:,n));
        indBestCycles(:,n) = getBestInd(cycles(:,n));
        indBestTeamDispersion(:,n) = getBestInd(teamDispersion(:,n));
        indBestNumPasses(:,n) = getBestInd(numPasses(:,n));
        indBestDistFromCentre(:,n) = getBestInd(distFromCentre(:,n));
        indBestGenotype_Diversity(:,n) = getBestInd(genotype_Diversity(:,n));
        indBestNearestNeighbors(:,n) = getBestInd(nearestNeighbors(:,n));
    else
        indBestFitness(:,n) = getBestInd(fitness(:,n));
        indBestRealFitness(:,n) = getBestInd(fitness(:,n));
        indBestGenotypic_Diversity(:,n) = getBestInd(fitness(:,n));
        indBestNovelty(:,n) = getBestInd(fitness(:,n));
        indBestComplexity(:,n) = getBestInd(fitness(:,n));
        indBestAge(:,n) = getBestInd(fitness(:,n));
        indBestCycles(:,n) = getBestInd(fitness(:,n));
        indBestTeamDispersion(:,n) = getBestInd(fitness(:,n));
        indBestNumPasses(:,n) = getBestInd(fitness(:,n));
        indBestDistFromCentre(:,n) = getBestInd(fitness(:,n));
        indBestGenotype_Diversity(:,n) = getBestInd(fitness(:,n));
        indBestNearestNeighbors(:,n) = getBestInd(fitness(:,n));
    end
end

% trim down (after having initialised variables) into dimensions of pop x
% gen (eg 300 x 100 for population of 300 and 100 generations)
fitness = fitness(1:k,:);
realFitness = realFitness(1:k,:);
genotypic_Diversity = genotypic_Diversity(1:k,:);
novelty = novelty(1:k,:);
complexity = complexity(1:k,:);
age = age(1:k,:);
cycles = cycles(1:k,:);
teamDispersion = teamDispersion(1:k,:);
numPasses = numPasses(1:k,:);
distFromCentre = distFromCentre(1:k,:);
genotype_Diversity = genotype_Diversity(1:k,:);
nearestNeighbors = nearestNeighbors(1:k,:);

indBestFitness = indBestFitness(1:k,:);
indBestRealFitness = indBestRealFitness(1:k,:);
indBestGenotypic_Diversity = indBestGenotypic_Diversity(1:k,:);
indBestNovelty = indBestNovelty(1:k,:);
indBestComplexity = indBestComplexity(1:k,:);
indBestAge = indBestAge(1:k,:);
indBestCycles = indBestCycles(1:k,:);
indBestTeamDispersion = indBestTeamDispersion(1:k,:);
indBestNumPasses = indBestNumPasses(1:k,:);
indBestDistFromCentre = indBestDistFromCentre(1:k,:);
indBestGenotype_Diversity = indBestGenotype_Diversity(1:k,:);
indBestNearestNeighbors = indBestNearestNeighbors(1:k,:);

%%
figure(1)
hold all
plot(fitness(indBestFitness),'DisplayName','fitness')
xlabel('Generation')
ylabel('Best fitness in pop at gen')
title('Best fitness')

figure(2)
hold all
plot(nanmean(fitness,1),'DisplayName','fitness')
xlabel('Generation')
ylabel('Average fitness in pop at gen')
title('Average fitness')
% hold all

% realFitness
figure(3)
hold all
plot(realFitness(indBestRealFitness),'DisplayName','realFitness')
xlabel('Generation')
ylabel('Best realFitness in pop at gen')
title('Best realFitness')

figure(4)
hold all
plot(nanmean(realFitness,1),'DisplayName','realFitness')
xlabel('Generation')
ylabel('Average realFitness in pop at gen')
title('Average realFitness')

% figure
% plot(cycles(indBestCycles))
% title('cycles')

% teamDispersion
figure(5)
hold all
plot(teamDispersion(indBestTeamDispersion))
title('Best teamDispersion')

figure(6)
hold all
plot(teamDispersion(indBestFitness))
title('teamDispersion for most fit genome')

figure(7)
hold all
plot(nanmean(teamDispersion,1))
title('Average teamDispersion')

% NumPasses
figure(8)
hold all
plot(numPasses(indBestNumPasses))
title('Best numPasses')

figure(9)
hold all
plot(numPasses(indBestFitness))
title('numPasses for most fit genome')

figure(10)
hold all
plot(nanmean(numPasses,1))
title('Average numPasses')

% distFromCentre
figure(11)
hold all
plot(distFromCentre(indBestDistFromCentre))
title('Best distFromCentre')

figure(12)
hold all
plot(distFromCentre(indBestFitness))
title('distFromCentre for most fit genome')

figure(13)
hold all
plot(nanmean(distFromCentre,1))
title('Average distFromCentre')

% age
figure(14)
hold all
plot(age(indBestFitness))
title('age for most fit genome')

figure(15)
hold all
plot(nanmean(age,1))
title('Average age')

figure(16)
hold all
boxplot(age)
title('Age')
%%
figure(17)
hold all
plot(normalize(horzcat(fitness(indBestFitness),cycles(indBestCycles),...
    teamDispersion(indBestTeamDispersion),numPasses(indBestNumPasses),distFromCentre(indBestDistFromCentre))))
title('metrics for best genome over generations')
legend('fitness','cycles/realFitness','teamDispersion','numPasses','distFromCentre')
