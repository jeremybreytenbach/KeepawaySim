function data = readFitnessData(folderPath,maxGens)
%{
folderPath = "E:\Google Drive\Academics\UCT - MIT\Research\Code\KeepawaySim\Data\20200301-2203";
maxGens = 3;
data = readFitnessData(folderPath,maxGens);
%}

data = cell(maxGens,1);

for k = 1:maxGens
   tempData = csvread(sprintf('%s//fitness_gen_%i.csv',folderPath,k));
   data{k} = reformatData(tempData);
end

function outputData = reformatData(inputData)
    outputData = nan(100,100,100);
    for k = 1:size(inputData)
        outputData(inputData(k,1)+1,inputData(k,2)+1,inputData(k,3)+1) = inputData(k,4);
    end