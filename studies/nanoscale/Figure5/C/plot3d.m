clear all
close all
dataFiles = {'ave_10.txt','ave_12.txt', 'ave_14.txt', 'ave_16.txt', 'ave_18.txt','ave_20.txt'};

[x, y, z] = meshgrid(0:700:700, 0:700:700, 0:600:600);


v = exp(-0.1 * (x.^2 + y.^2 + z.^2));


xslice = [];      
yslice = [10, 12, 14, 16, 18, 20];
zslice = [];
colors = {[199 77 38], [227 141 38], [241 204 116], [95 156 97], [94 167 184], [100 100 172]};
symbols = {'h', 'diamond', 'v', 's', '^','o'};
for k = 1:length(dataFiles)
    fileName = dataFiles{k};
        data = load(fileName);

    xData = data(:,1);
    yData = data(:,2);
    am = 8+k*2;
    sprintf('%.2f', am)

 scatter3(xData,am,yData,100,'filled', symbols{k},'Markerfacecolor',colors{k}/255)
 hold on;
end

h = slice(x, y, z, v, xslice, yslice, zslice);

for i = 1:length(h)
    set(h(i), 'FaceColor', [.7 .7 .7], 'EdgeColor', 'none', 'FaceAlpha', 0.1);
end


xlabel('f (MHz)','Interpreter','latex');
ylabel('A (\AA)','Interpreter','latex');
zlabel('$N_{max}$','Interpreter','latex');
set(gca, 'fontsize', 15);
set(get(gca,'xlabel'),'rotation',15);
set(get(gca,'ylabel'),'rotation',-25);
set(gca, 'FontSize', 20, 'TickLabelInterpreter','latex');
zlim([0 700])
ylim([10 20])
xlim([0 700])
grid off;
hold off;