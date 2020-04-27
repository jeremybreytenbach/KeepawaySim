function data = readFitnessData(folderPath,maxGens,fitnessType)
% fitnessType = 'real fitness' | 'fitness'
%{
folderPath = "E:\Google Drive\Academics\UCT - MIT\Research\Code\KeepawaySim\Data\20200301-2203";
maxGens = 3;
data = readFitnessData(folderPath,maxGens);
%}
if nargin < 3 || strcmpi(fitnessType,'real fitness')
    fitnessTypeString = 'real_fitness_gen';
else
    fitnessTypeString = 'fitness_gen';
end

data = cell(maxGens,1);

for k = 1:maxGens
   tempData = csvread(sprintf('%s//%s_%i.csv',folderPath,fitnessTypeString,k));
   data{k} = reformatData(tempData);
end

function outputData = reformatData(inputData)
    outputData = nan(100,100,100);
    for k = 1:size(inputData)
        outputData(inputData(k,1)+1,inputData(k,2)+1,inputData(k,3)+1) = inputData(k,4);
    end