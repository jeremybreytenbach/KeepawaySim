function legendFigures(figNums,legend1,legend2)
%{
 legendFigures([1:15,18,20,21],'ep:5 pop:300 gens:100 method:3 ME:true','ep:5 pop:150 gens:55 method:3 ME:true')
 legendFigures([1:25])
%}

for k = figNums
    fig = figure(k);
%     legend(legend1,legend2);
    fig.WindowStyle = 'docked';
end