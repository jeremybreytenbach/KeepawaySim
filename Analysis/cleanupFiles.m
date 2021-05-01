%% Setup directories
dataPath = sprintf('E:\\Google Drive\\Academics\\UCT - MIT\\Research\Code\\KeepawaySim\\Analysis\\CHPC\\20210409 T 230000\\executableCode2\\');

experimentManagerPath = sprintf('E:\\Google Drive\\Academics\\UCT - MIT\\Research\\Code\\KeepawaySim\\Experiment Management\\');

listing = struct2table(dir(dataPath));
fileNames = string(listing.name);
fileNames = fileNames(contains(fileNames,'.csv'));

indFirstExperiment = strcmp(listing.name,'fitness_gen_1.csv');

experimentDate = [datestr(listing.datenum(indFirstExperiment),'yyyymmdd T HHMM'),'00'];

newPath = strcat(experimentManagerPath,experimentDate);
mkdir(newPath);

%% Move data files
for k = 1:length(fileNames)
    movefile(strcat(dataPath,fileNames(k)),strcat(newPath,"\",fileNames(k)),'f');
end

%% Store Champs, Populations, Species data
path1 = 'E:\\Google Drive\\Academics\\UCT - MIT\\Research\\Code\\KeepawaySim\\HyperNEAT Keepaway\\Sources\\KeepAway\\bin\\Debug\\Champs';
path2 = 'E:\\Google Drive\\Academics\\UCT - MIT\\Research\\Code\\KeepawaySim\\HyperNEAT Keepaway\\Sources\\KeepAway\\bin\\Debug\\Populations';
path3 = 'E:\\Google Drive\\Academics\\UCT - MIT\\Research\\Code\\KeepawaySim\\HyperNEAT Keepaway\\Sources\\KeepAway\\bin\\Debug\\Species';

newPath1 = strcat(newPath,'\','Champs\');
newPath2 = strcat(newPath,'\','Populations\');
newPath3 = strcat(newPath,'\','Species\');

mkdir(newPath1);
mkdir(newPath2);
mkdir(newPath3);

copyfile(path1,newPath1);
copyfile(path2,newPath2);
copyfile(path3,newPath3);

%% Delete files in Path1, Path2, Path3 (clear directories for new/next experiment)
rmdir(path1,'s')
rmdir(path2,'s')
rmdir(path3,'s')

mkdir(path1);
mkdir(path2);
mkdir(path3);


