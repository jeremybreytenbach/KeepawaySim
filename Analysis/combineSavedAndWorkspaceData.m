S = load('experimentData_2020-08-08 T 002522');


S.averageRealFitness(end+1) = averageRealFitness;
S.data(end+1) = data;
S.experimentNames(end+1) = experimentNames;
S.friendlyExperimentNames(end+1) = friendlyExperimentNames;
S.indexes(end+1) = indexes;
S.metric(end+1) = metric;


averageRealFitness = S.averageRealFitness;
data = S.data;
experimentNames = S.experimentNames;
friendlyExperimentNames = S.friendlyExperimentNames;
indexes = S.indexes;
metric = S.metric;
