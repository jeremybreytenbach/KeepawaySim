
for itteration = 1:100
    % Load file
    SeedXMLDoc = xml2struct(sprintf('E:\\Google Drive\\Academics\\UCT - MIT\\Research\\Code\\KeepawaySim\\Experiment Management\\20210402 T 213100\\Populations\\G%04dPop.xml',itteration));
    
    % track a particular genome (for example, the best one)
    
%     D = cell(10,1);
    
    for n = 1 %:length(SeedXMLDoc.Population.Genomes.NetworkGenome)
        % Set up variables
        population(n).linkTable = table('Size',[1 3],'VariableTypes',{'double','double','double'},'VariableNames',{'Source','Target','Weight'});
        population(n).nodeTable = table('Size',[1 4],'VariableTypes',{'double','categorical','categorical','double'},'VariableNames',{'Id','Type','Function','Layer'});
        
        % Extract node data
        for k = 1:length(SeedXMLDoc.Population.Genomes.NetworkGenome{n}.Nodes.NodeGene)
            population(n).nodeTable.Id(k) = str2double(SeedXMLDoc.Population.Genomes.NetworkGenome{n}.Nodes.NodeGene{k}.Attributes.Id)+1;
            population(n).nodeTable.Type(k) = categorical({SeedXMLDoc.Population.Genomes.NetworkGenome{n}.Nodes.NodeGene{k}.Attributes.Type});
            population(n).nodeTable.Function(k) = categorical({SeedXMLDoc.Population.Genomes.NetworkGenome{n}.Nodes.NodeGene{k}.Attributes.Function});
            population(n).nodeTable.Layer(k) = str2double(SeedXMLDoc.Population.Genomes.NetworkGenome{n}.Nodes.NodeGene{k}.Attributes.Layer);
        end
        
        % Extract link data
        for k = 1:length(SeedXMLDoc.Population.Genomes.NetworkGenome{n}.Links.LinkGene)
            population(n).linkTable.Source(k) = str2double(SeedXMLDoc.Population.Genomes.NetworkGenome{n}.Links.LinkGene{k}.Attributes.Source)+1;
            population(n).linkTable.Target(k) = str2double(SeedXMLDoc.Population.Genomes.NetworkGenome{n}.Links.LinkGene{k}.Attributes.Target)+1;
            population(n).linkTable.Weight(k) = str2double(SeedXMLDoc.Population.Genomes.NetworkGenome{n}.Links.LinkGene{k}.Attributes.Weight);
        end
        
        D{n} = digraph( population(n).linkTable.Source,...
            population(n).linkTable.Target,...
            population(n).linkTable.Weight,...
            string([1:max(population(n).nodeTable.Id)]));
    end
    
    for k = 1 %:length(SeedXMLDoc.Population.Genomes.NetworkGenome)
        figure(k)
        h = plot(D{k},'EdgeLabel',D{k}.Edges.Weight);
        layout(h,'layered','Direction','right',...
            'Sources',population(n).nodeTable.Id(population(n).nodeTable.Type == 'Input'),...
            'Sinks',population(n).nodeTable.Id(population(n).nodeTable.Type == 'Output'),...
            'AssignLayers','alap');
    end
end
