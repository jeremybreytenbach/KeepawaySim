function legendFigures(legend1,legend2,figNums)
%{
 legendFigures('ep:5 pop:300 gens:100 method:3 ME:true','ep:5 pop:150 gens:55 method:3 ME:true',[1:15,18,20,21])
%}

for k = figNums
    figure(k)
    legend(legend1,legend2);
end