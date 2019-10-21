load(sprintf('..//Data//fitness.mat'));

fitness = real(fitness);
fitness(ismissing(fitness,0)) = nan;

% fitness2 = fitness*100;
% fitness3 = zscore(fitness);
% 
%  x = fitness(:,:,1);
%  y = fitness(:,:,2);
%  z = fitness(:,:,3);
%  figure; plot3(x,y,z,'.-'); %the figure is attached below
% 
% figure
% plot3(fitness(:,1,1),squeeze(fitness(1,:,1)),squeeze(fitness(1,1,:)),'o')
% 
% figure
% plot3(fitness2(:,1,1),squeeze(fitness2(1,:,1))',squeeze(fitness2(1,1,:)),'o')
% 
% figure
% plot3(fitness3(:,1,1),squeeze(fitness3(1,:,1)),squeeze(fitness3(1,1,:)),'o')
% 
% all(all(all(fitness == 0)))
% 
% figure
% h = histogram(fitness2(:),30)
% 
% figure
% % [xx,yy] = meshgrid(1:100,1:100);
% scatter3(1:100,1:100,1:100)


%%
% n = 0;
% figure
% for k = 1:100
%     for kk = 1:100
%         for kkk = 1:100
%             n = n+1;
%             hold on
%             scatter3(k,kk,kkk,fitness(n)*100)
%         end
%         drawnow
%     end
% end

https://www.mathworks.com/help/matlab/visualize/visualizing-four-dimensional-data.html?s_tid=srchtitle

