function data = readFitnessData(folderPath,maxGens)
%{
folderPath = "E:\Google Drive\Academics\UCT - MIT\Research\Code\KeepawaySim\Data\20200301-2203";
maxGens = 3;
data = readFitnessData(folderPath,maxGens);
%}

data = cell(maxGens,1);

for k = 1:maxGens
   data{k} = csvread(sprintf('%s//%s_%i.csv',folderPath,'real_fitness_gen',k));
   data2 = csvread(sprintf('%s//%s_%i.csv',folderPath,'fitness_gen',k));
   data{k}(:,end+1) = data2(:,end);
end