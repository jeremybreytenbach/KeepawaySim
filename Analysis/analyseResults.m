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
numGenerations = 55;

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
    filename = sprintf(['E:/Google Drive/Academics/UCT - MIT/Research/Code/KeepawaySim/'...
        'HyperNEAT Keepaway/Sources/KeepAway/bin/Debug/Populations/G00%02iPop.xml'],n);
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
end

% trim down (after having initialised variables)
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
figure
plot(fitness(indBestFitness),'DisplayName','fitness')
xlabel('Generation')
ylabel('Best fitness in pop at gen')
title('Best fitness')

figure
plot(nanmean(fitness,1),'DisplayName','fitness')
xlabel('Generation')
ylabel('Average fitness in pop at gen')
title('Average fitness')
% hold all

% realFitness
figure
plot(realFitness(indBestRealFitness),'DisplayName','realFitness')
xlabel('Generation')
ylabel('Best realFitness in pop at gen')
title('Best realFitness')

figure
plot(nanmean(realFitness,1),'DisplayName','realFitness')
xlabel('Generation')
ylabel('Average realFitness in pop at gen')
title('Average realFitness')

% figure
% plot(cycles(indBestCycles))
% title('cycles')

% teamDispersion
figure
plot(teamDispersion(indBestTeamDispersion))
title('Best teamDispersion')

figure
plot(teamDispersion(indBestFitness))
title('teamDispersion for most fit genome')

figure
plot(nanmean(teamDispersion,1))
title('Average teamDispersion')

% NumPasses
figure
plot(numPasses(indBestNumPasses))
title('Best numPasses')

figure
plot(numPasses(indBestFitness))
title('numPasses for most fit genome')

figure
plot(nanmean(numPasses,1))
title('Average numPasses')

% distFromCentre
figure
plot(distFromCentre(indBestDistFromCentre))
title('Best distFromCentre')

figure
plot(distFromCentre(indBestFitness))
title('distFromCentre for most fit genome')

figure
plot(nanmean(distFromCentre,1))
title('Average distFromCentre')

% age
figure
plot(age(indBestFitness))
title('age for most fit genome')

figure
plot(nanmean(age,1))
title('Average age')

figure
boxplot(age)
title('Age')
%%
figure
plot(normalize(horzcat(fitness(indBestFitness),cycles(indBestCycles),...
    teamDispersion(indBestTeamDispersion),numPasses(indBestNumPasses),distFromCentre(indBestDistFromCentre))))
title('metrics for best genome over generations')
legend('fitness','cycles','teamDispersion','numPasses','distFromCentre')
