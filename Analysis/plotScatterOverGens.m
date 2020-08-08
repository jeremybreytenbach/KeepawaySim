for gen = 1:20:100
    figure
    % hold all
    n = 0;
    for expNum = 1:length(experimentNames)
        try
            n = n+1;
            subplot(2,3,n)
            scatter3(data{expNum}{gen}(:,1)./100,data{expNum}{gen}(:,2)./100,data{expNum}{gen}(:,3)./100,...
                data{expNum}{gen}(:,4)*0.1,data{expNum}{gen}(:,4)*0.1,'filled')
            xlabel('team dispersion')
            ylabel('no passes')
            zlabel('dist from centre')
            title(sprintf(['Normalised fitness landscape / Map of elites at gen %d\n' friendlyExperimentNames{expNum}],gen))
            %       thisAxis = gca;
            %       thisAxis.YTick = 5:5:15;
            %       thisAxis.ZTick = 5:5:15;
            %       axis([0 100 0 20 0 20])
            grid on
            colormap(jet);
            colorbar;
            axis([0 20 0 300 0 20])
        catch
        end
    end
end