
20200705 T 163200
data = readFitnessData(folderPath,numGenerations);


inputData(:,1:3) = inputData(:,1:3)./100;
figure
scatter3(inputData(:,1),inputData(:,2),inputData(:,3),inputData(:,4)*10,inputData(:,4)*10,'filled')
colorbar