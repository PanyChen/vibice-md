clear all;
data = readmatrix('density.txt');


x = data(:, 1);
y = data(:, 2);
residence_time = data(:, 6);


numPoints = 1000; 
x_lin = linspace(min(x), max(x), numPoints);
y_lin = linspace(min(y), max(y), numPoints);
[X, Y] = meshgrid(x_lin, y_lin);


Z = griddata(x, y, residence_time, X, Y, 'linear');


figure('Position', [100, 100, 400, 380])
imagesc(x_lin, y_lin, Z);
c = colormap((slanCM('ice')));
clim([8 18]); 

set(gca, 'YDir', 'normal'); 
cb = colorbar; 
cb.Label.Interpreter = 'latex'; 
cb.TickLabelInterpreter = 'latex'; 
cb.FontSize = 20; 

xlabel('Y Coordinate (\AA)', 'FontSize', 20, 'Interpreter', 'latex');
ylabel('Z Coordinate (\AA)', 'FontSize', 20, 'Interpreter', 'latex');

set(gca,'fontsize', 20,'TickLabelInterpreter','latex');
ax = gca;
ax.LineWidth = 1.5;