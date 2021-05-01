warning('off')
for iteration = 1:100
    % Load file
    SeedXMLDoc = xml2struct(sprintf(['E:\\Google Drive\\Academics\\UCT - MIT\\Research\\Code\\KeepawaySim\\HyperNEAT Keepaway\\'...
        'Sources\\KeepAway\\bin\\Debug\\Sub.xml'],iteration));
    
    % track a particular genome (for example, the best one)
    
    n = 1;
    %     for n = 1 %:length(SeedXMLDoc.Population.Genomes.NetworkGenome)
    % Set up variables
    champs(iteration).linkTable = table('Size',[1 3],'VariableTypes',{'double','double','double'},'VariableNames',{'Source','Target','Weight'});
    champs(iteration).nodeTable = table('Size',[1 4],'VariableTypes',{'double','categorical','categorical','double'},'VariableNames',{'Id','Type','Function','Layer'});
    
    % Extract node data
    for k = 1:length(SeedXMLDoc.NetworkGenome.Nodes.NodeGene)
        champs(iteration).nodeTable.Id(k) = str2double(SeedXMLDoc.NetworkGenome.Nodes.NodeGene{k}.Attributes.Id)+1;
        champs(iteration).nodeTable.Type(k) = categorical({SeedXMLDoc.NetworkGenome.Nodes.NodeGene{k}.Attributes.Type});
        champs(iteration).nodeTable.Function(k) = categorical({SeedXMLDoc.NetworkGenome.Nodes.NodeGene{k}.Attributes.Function});
        champs(iteration).nodeTable.Layer(k) = str2double(SeedXMLDoc.NetworkGenome.Nodes.NodeGene{k}.Attributes.Layer);
    end
    % Extract link data
    for k = 1:length(SeedXMLDoc.NetworkGenome.Links.LinkGene)
        champs(iteration).linkTable.Source(k) = str2double(SeedXMLDoc.NetworkGenome.Links.LinkGene{k}.Attributes.Source)+1;
        champs(iteration).linkTable.Target(k) = str2double(SeedXMLDoc.NetworkGenome.Links.LinkGene{k}.Attributes.Target)+1;
        champs(iteration).linkTable.Weight(k) = str2double(SeedXMLDoc.NetworkGenome.Links.LinkGene{k}.Attributes.Weight);
    end
    
    D{iteration} = digraph( champs(iteration).linkTable.Source,...
        champs(iteration).linkTable.Target,...
        champs(iteration).linkTable.Weight,...
        string([1:max(champs(iteration).nodeTable.Id)]));
    %     end
end

for k = 1:100
    figure
    h = plot(D{k},'EdgeLabel',D{k}.Edges.Weight);
    layout(h,'layered','Direction','right',...
        'Sources',champs(k).nodeTable.Id(champs(k).nodeTable.Type == 'Input'),...
        'Sinks',champs(k).nodeTable.Id(champs(k).nodeTable.Type == 'Output'),...
        'AssignLayers','alap');
    drawnow
%     pause(0.25)
end
warning('on')
