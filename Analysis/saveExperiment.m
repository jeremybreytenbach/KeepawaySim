% Get unique datestamp for experiment
dateToday = datestr(now,'yyyymmdd T HHMMSS');

%% Save sim settings and results
fileNames = ["Initialization.xml","KeepawayConfig.xml","HyperNEAT.xml","Parameters.xml",...
    "Mutation.xml","Reproduction.xml","Saving.xml","Speciation.xml","Testing.xml","Seed.xml",...
    "Population.xml"];

rootPath = "E:\Google Drive\Academics\UCT - MIT\Research\Code\KeepawaySim\HyperNEAT Keepaway\Sources\KeepAway\bin\Debug\";
newPath = "E:\Google Drive\Academics\UCT - MIT\Research\Code\KeepawaySim\Experiment Management\";

mkdir(strcat(newPath,dateToday));

for k = 1:length(fileNames)
    copyfile(strcat(rootPath,fileNames(k)),strcat(newPath,dateToday,"\",fileNames(k)),'f');
end

%% Save champ data from sim
fileNames = "ChampStats.txt";
rootPath = "E:\Google Drive\Academics\UCT - MIT\Research\Code\KeepawaySim\HyperNEAT Keepaway\Sources\KeepAway\bin\Debug\Champs\";
for k = 1:length(fileNames)
    copyfile(strcat(rootPath,fileNames(k)),strcat(newPath,dateToday,"\",fileNames(k)),'f');
end
%% Save analytics and results
fileNames = ["AnalyseFitness.m","analyseResults.m","fitnessVis.fig"];

rootPath = "E:\Google Drive\Academics\UCT - MIT\Research\Code\KeepawaySim\Analysis\";

for k = 1:length(fileNames)
    copyfile(strcat(rootPath,fileNames(k)),strcat(newPath,dateToday,"\",fileNames(k)),'f');
end
