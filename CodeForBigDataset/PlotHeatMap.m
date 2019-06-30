load('corrMatrix.mat');

h = heatmap(corrMatrix);


% h.Title = 'Heatmap for 29 features';
h.XLabel = 'Feature ID (F_id)';
h.YLabel = 'Feature ID (F_id)';
h.XDisplayLabels = {'1', '', '', '', '5', '', '', '', '', '10', '', '', '', '', '15', '', '', '', '', '20', '', '', '', '', '25', '', '', '', '29'};
h.YDisplayLabels = {'1', '', '', '', '5', '', '', '', '', '10', '', '', '', '', '15', '', '', '', '', '20', '', '', '', '', '25', '', '', '', '29'};


% newheatmap(corrMatrix, 1:29, 1:29, '%0.2f', 'Colormap', 'red', ...
%         'Colorbar', true);
    
% X = arrayfun(@(x){num2str(x)},1:5:29);
% colormap hsv


% saveas(h, 'figures/HeatMapForHuman.eps', 'psc2');