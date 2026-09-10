clear all
close all
clf;

data = readmatrix('3dPressure.txt','NumHeaderLines',1);

frequency = data(:, 1);
amplitude = data(:, 2);
pressure = -data(:, 3);

xResolution = 50; 
yResolution = 50; 


uniquefrequency = linspace(min(frequency), max(frequency), xResolution);
uniqueamplitude = linspace(min(amplitude), max(amplitude), yResolution);
[frequencyGrid, amplitudeGrid] = meshgrid(uniquefrequency, uniqueamplitude);


pressureGrid = griddata(frequency, amplitude, pressure, frequencyGrid, amplitudeGrid, 'linear');

points = [frequency amplitude pressure];


filtered_points = points(all(points ~= 0, 2), :);


fre_filtered = filtered_points(:, 1);
amp_filtered = filtered_points(:, 2);
pre_filtered = filtered_points(:, 3);


figure(1);
s = surf(frequencyGrid, amplitudeGrid, pressureGrid,'EdgeColor','none','FaceAlpha',0.1);
hold on
uniqueamplitudeValues = unique(amplitude);
colors = {[199 77 38], [227 141 38], [241 204 116], [95 156 97], [94 167 184], [100 100 172]};
symbols = {'h', 'diamond', 'v', 's', '^','o'};
numSymbols = length(symbols);

 for   i = 3:8
    idx = (amplitude == uniqueamplitudeValues(i));
    xi = frequency(idx);
    zi = pressure(idx);
    b = mean(zi);
    scatter3(xi, uniqueamplitudeValues(i),zi,100,'filled', 'Markerfacecolor', colors{i-2}/255,'MarkerEdgeColor','black');
    hold on;
end

zlabel('$P_{mag}$ (MPa)','Interpreter','latex');
zlim([0 300]);
ylim([10 20]);
set(gca, 'fontsize', 15);
set(gca, 'FontSize', 20, 'TickLabelInterpreter','latex');
set(gca, 'FontSize', 20, 'TickLabelInterpreter','latex');
set(gca,'XTick',[], 'YTick', [],'YTickLabel',[],'XTickLabel',[])
colormap("sky");
grid off;
hold off;