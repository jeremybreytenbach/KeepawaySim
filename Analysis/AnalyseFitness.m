fitness = zeros(100,100,100);

for k = 0:99    
    S = load(sprintf('..//Data//fitness%i.mat',k));
    fitness(1:100,1:100,k+1) =  S.(sprintf('fitness_%i',k));
end

figure
plot3(fitness(:,1,1),squeeze(fitness(1,:,1)),squeeze(fitness(1,1,:)))

all(all(all(fitness == 0)))


for k = 0:99;fitness(1:100,1:100,k+1) =  eval(sprintf('fitness_%i',k));end