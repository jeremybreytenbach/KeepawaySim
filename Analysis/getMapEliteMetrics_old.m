function output = getMapEliteMetrics_old(data,experimentNames)

% Global fitness. For each run, the single highest-performing solution found 
% by that algorithm anywhere in the search space divided by the highest performance 
% possible in that domain. If it is not known what the maximum theoretical performance 
% is, as is the case for all of our domains, we estimate it by dividing by the 
% highest performance found by any algorithm in any run. This metric is independent 
% of the behavior space.
% Summary: At each gen, highest fitness in map / highestMax

highestMax = 1000;
for kn = 1:length(experimentNames)
    for k = 1:length(data{kn})
        globalFitness(k,kn) = max(data{kn}{k}(:,4)) / highestMax;
    end
end

% Coverage. Measures how many cells of the feature space a run of an algorithm 
% is able to fill of the total number that are possible to fill. This metric 
% depends on the behavior space because some combinations of behavioral descriptors 
% might be impossible.
% Summary: At each gen, percent of filled cells = ~nans

searchSpace = 20*20*300;
for kn = 1:length(experimentNames)
    for k = 1:length(data{kn})
        coverage(k,kn) = nnz(~isnan(data{kn}{k}(:,4))) / searchSpace;
    end
end

% Global reliability. This metric computes the average fitness for all the cells 
% of the map. For each run, the average across all cells of the highest-performing 
% solution the algorithm found for each cell (0 if it did not produce a solution 
% in that cell) divided by the best known performance for that cell as found by 
% any run of any algorithm. Cells for which no solution was found by any run of 
% any algorithm are not included in the calculation (to avoid dividing by zero, 
% and because it may not be possible to fill such cells and algorithms thus should 
% not be penalized for not doing so). This metric depends on the behavior space. 
% Summary: At each gen, average of (fitness / best fitness ever found in that cell)

for kn = 1:length(experimentNames)
    for k = 1:length(data{kn})
   
        globalReliability = mean(
    end
end

% Precision (opt-in reliability). This metric computes the average fitness for 
% the filled cells only. For each run, if (and only if) this run creates a solution 
% in a cell, the average across all such cells of the highest performing solution 
% produced for that cell divided by the highest performing solution any algorithm 
% found for that cell. This metric depends on the behavior space.
% Summary: at each gen, average (fitness/ max fitness in that cell)








%% Old global reliability code
% for gens = 1:100
%     allCoords = unique(vertcat(data{1}{gens}(:,1:3),data{2}{gens}(:,1:3),data{3}{gens}(:,1:3),data{4}{gens}(:,1:3),data{5}{gens}(:,1:3)),'rows');
%     maxFitnessAtCoord = nan(length(allCoords),1);
%     
%     parfor k = 1:length(allCoords) % for each cell, what is the highest ever found across experiments
%         ind1 = data{1}{gens}(:,1) == allCoords(k,1) & ...
%             data{1}{gens}(:,2) == allCoords(k,2) & ...
%             data{1}{gens}(:,3) == allCoords(k,3);
%         
%         ind2 = data{2}{gens}(:,1) == allCoords(k,1) & ...
%             data{2}{gens}(:,2) == allCoords(k,2) & ...
%             data{2}{gens}(:,3) == allCoords(k,3);
%         
%         ind3 = data{3}{gens}(:,1) == allCoords(k,1) & ...
%             data{3}{gens}(:,2) == allCoords(k,2) & ...
%             data{3}{gens}(:,3) == allCoords(k,3);
%         
%         ind4 = data{4}{gens}(:,1) == allCoords(k,1) & ...
%             data{4}{gens}(:,2) == allCoords(k,2) & ...
%             data{4}{gens}(:,3) == allCoords(k,3);
%         
%         maxFitnessAtCoord(k) = max([max(data{1}{gens}(ind1,4)),...
%             max(data{2}{gens}(ind2,4)),...
%             max(data{3}{gens}(ind3,4)),...
%             max(data{4}{gens}(ind4,4))]);
%     end
%     
%     for kn = 1:length(experimentNames)
%         clear cellReliability
%         for knn = 1:length(data{kn}{gens})
%             ind = allCoords(:,1) == data{kn}{gens}(knn,1) &...
%                 allCoords(:,2) == data{kn}{gens}(knn,2) &...
%                 allCoords(:,3) == data{kn}{gens}(knn,3);
%             
%             cellReliability(knn) = data{kn}{gens}(knn,4)./maxFitnessAtCoord(ind);
%         end
%         globalReliability(gens,kn) = mean(cellReliability);
%     end
% end