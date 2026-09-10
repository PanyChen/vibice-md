
dataFiles = {'ave_10.txt','ave_12.txt', 'ave_14.txt', 'ave_16.txt', 'ave_18.txt','ave_20.txt'}; % the number indicates amplitude
plotHandles = [];
legendLabels = {};
figure('Name', 'Fit: Max Ice Molecules vs Period');

hold on;
legendEntries = cell(length(dataFiles), 1);
colors = {[199 77 38], [227 141 38], [241 204 116], [95 156 97], [94 167 184], [100 100 172]};
symbols = {'h', 'diamond', 'v', 's', '^','o'};


for k = 1:length(dataFiles)
    fileName = dataFiles{k};
    

    data = load(fileName);
    xData = data(:,1);
    yData = data(:,2);
    zData = 1000 ./ xData; 
    [sortedZ, sortOrder] = sort(zData);
    sortedY = yData(sortOrder);
    p = plot(sortedZ, sortedY,symbols{k}, 'MarkerSize',10,'linestyle','--','linewidth',1, 'MarkerFaceColor',colors{k}/255,'Color', colors{k}/255); % Plot data points separately
    plotHandles = [plotHandles, p];
    i = k*2 + 10;
    legendLabels{end+1} = sprintf('%d \\AA', i); 
    legendEntries{k} = fileName;
    
end


lgd = legend(flip(plotHandles), flip(legendLabels), 'Location', 'best', 'Interpreter','latex');
legend boxoff
lgd.Direction = 'reverse';
set(lgd, 'FontSize', 20);


xlabel('T (ns)', 'Interpreter', 'latex');
ylabel('$N_{\mathrm{max}}$', 'Interpreter', 'latex');
set(gca, 'FontSize', 20, 'TickLabelInterpreter','latex');
box on;
grid off;
xlim([0 40]); 
ylim([150 500]); 
hold off;
set(gca, 'Color', 'none'); 
set(gcf, 'Color', 'none'); 
width = 8;  
height = 5.76; 
set(gcf, 'Units', 'inches', 'Position', [1, 1, width, height]); 
set(gcf, 'PaperPositionMode', 'auto');
set(gca,'fontsize', 20,'TickLabelInterpreter','latex');
box on;
hold off;
export_fig('transparent_figure.png', '-png', '-transparent','-r900');