% Get unique datestamp for experiment
dateToday = datestr(now,'yyyymmdd T HHMMSS');

%% Save sim settings and results
fileNames = ["Initialization.xml","KeepawayConfig.xml","HyperNEAT.xml","Parameters.xml",...
    "Mutation.xml","Reproduction.xml","Saving.xml","Speciation.xml","Testing.xml","Seed.xml",...
    "Populations\G0025Pop.xml","Populations\G0050Pop.xml",...
...     "Populations\G0075Pop.xml","Populations\G0100Pop.xml",...
    "Champs\G0025Champ.xml","Champs\G0050Champ.xml",...
...     "Champs\G0075Champ.xml","Champs\G0100Champ.xml",...
    "Species\G0025Species0000.xml","Species\G0050Species0000.xml"]%,...
...     "Species\G0075Species0000.xml","Species\G0100Species0000.xml"];

rootPath = "E:\Google Drive\Academics\UCT - MIT\Research\Code\KeepawaySim\HyperNEAT Keepaway\Sources\KeepAway\bin\Debug\";
newPath = "E:\Google Drive\Academics\UCT - MIT\Research\Code\KeepawaySim\Experiment Management\";

mkdir(strcat(newPath,dateToday));
mkdir(strcat(newPath,dateToday,"\Populations"));
mkdir(strcat(newPath,dateToday,"\Champs"));
mkdir(strcat(newPath,dateToday,"\Species"));

for k = 1:length(fileNames)
    copyfile(strcat(rootPath,fileNames(k)),strcat(newPath,dateToday,"\",fileNames(k)),'f');
end

%% Save champ data from sim
fileNames = ["ChampStats.txt","PopStats.txt"];
rootPath = "E:\Google Drive\Academics\UCT - MIT\Research\Code\KeepawaySim\HyperNEAT Keepaway\Sources\KeepAway\bin\Debug\Champs\";
for k = 1:length(fileNames)
    copyfile(strcat(rootPath,fileNames(k)),strcat(newPath,dateToday,"\",fileNames(k)),'f');
end

%% Save species data from sim
fileNames = ["SpeciesStats.txt"];
rootPath = "E:\Google Drive\Academics\UCT - MIT\Research\Code\KeepawaySim\HyperNEAT Keepaway\Sources\KeepAway\bin\Debug\Species\";
for k = 1:length(fileNames)
    copyfile(strcat(rootPath,fileNames(k)),strcat(newPath,dateToday,"\",fileNames(k)),'f');
end

%% Save analytics and results
fileNames = ["AnalyseFitness.m","analyseResults.m","fitnessVis.fig"];

rootPath = "E:\Google Drive\Academics\UCT - MIT\Research\Code\KeepawaySim\Analysis\";

for k = 1:length(fileNames)
    copyfile(strcat(rootPath,fileNames(k)),strcat(newPath,dateToday,"\",fileNames(k)),'f');
end

%% Save fitness Elite map
fileNames = ["fitness.mat"];

rootPath = "E:\Google Drive\Academics\UCT - MIT\Research\Code\KeepawaySim\Data\";

for k = 1:length(fileNames)
    copyfile(strcat(rootPath,fileNames(k)),strcat(newPath,dateToday,"\",fileNames(k)),'f');
end
