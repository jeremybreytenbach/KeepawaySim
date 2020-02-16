
filename = 'E:\Google Drive\Academics\UCT - MIT\Research\Code\KeepawaySim\HyperNEAT Keepaway\Sources\KeepAway\bin\Debug\Population.xml';

xDoc = xml2struct(filename)


for k = 1:length(xDoc.Population.Genomes.NetworkGenome)
    fitness2(k) = str2double(xDoc.Population.Genomes.NetworkGenome{k}.Attributes.Fitness);
    cycles(k) = str2double(xDoc.Population.Genomes.NetworkGenome{k}.BehaviorType.bVector.double{1}.Text);
    teamDispersion(k) = str2double(xDoc.Population.Genomes.NetworkGenome{k}.BehaviorType.bVector.double{2}.Text);
    numPasses(k) = str2double(xDoc.Population.Genomes.NetworkGenome{k}.BehaviorType.bVector.double{3}.Text);
    distFromCentre(k) = str2double(xDoc.Population.Genomes.NetworkGenome{k}.BehaviorType.bVector.double{4}.Text);
end

figure
plot(fitness2)
title('fitness')

figure
plot(cycles)
title('cycles')

figure
plot(teamDispersion)
title('teamDispersion')

figure
plot(numPasses)
title('numPasses')

figure
plot(distFromCentre)
title('distFromCentre')
