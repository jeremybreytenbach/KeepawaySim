S = load('experimentData_2021-01-01 T 211308');


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

%% Delete first entry (to keep array to 6 in length)
averageRealFitness(1) = [];
data(1) = [];
experimentNames(1) = [];
friendlyExperimentNames(1) = [];
indexes(1) = [];
metric(1) = [];