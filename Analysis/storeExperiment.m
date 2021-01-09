dataPath = sprintf('E:\\Google Drive\\Academics\\UCT - MIT\\Research\\Code\\KeepawaySim\\Data\\');

experimentManagerPath = sprintf('E:\\Google Drive\\Academics\\UCT - MIT\\Research\\Code\\KeepawaySim\\Experiment Management\\');

listing = struct2table(dir(dataPath));
fileNames = string(listing.name);
fileNames = fileNames(contains(fileNames,'.csv'));

indFirstExperiment = strcmp(listing.name,'fitness_gen_1.csv');

experimentDate = [datestr(listing.datenum(indFirstExperiment),'yyyymmdd T HHMM'),'00'];

newPath = strcat(experimentManagerPath,experimentDate);
mkdir(newPath);

for k = 1:length(fileNames)
    movefile(strcat(dataPath,fileNames(k)),strcat(newPath,"\",fileNames(k)),'f');
end

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

