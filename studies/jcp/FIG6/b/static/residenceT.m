clearvars; close all; clc;

data = readmatrix('resTmap_xyz.txt');

x = data(:,1);
y = data(:,2);
residence_time = data(:,3);

unique_x = unique(x);
unique_y = unique(y);

[X, Y] = meshgrid(unique_x, unique_y);
Z = nan(size(X));

for i = 1:length(x)
    row_idx = find(unique_y == y(i));
    col_idx = find(unique_x == x(i));
    Z(row_idx, col_idx) = residence_time(i);
end

Z(isnan(Z)) = 0;

figure('Position', [100, 100, 400, 380]);
imagesc(unique_x, unique_y, Z');
colormap(flipud(slanCM('rdylbu')));

set(gca, 'YDir', 'normal');
clim([2.5 7.5]);

xlabel('Y Coordinate (\AA)', 'FontSize', 20, 'Interpreter', 'latex');
ylabel('Z Coordinate (\AA)', 'FontSize', 20, 'Interpreter', 'latex');

ax = gca;
ax.FontSize = 20;
ax.TickLabelInterpreter = 'latex';
ax.LineWidth = 1.5;

cb = colorbar;
cb.TickLabelInterpreter = 'latex';
cb.FontSize = 20;
cb.LineWidth = 1.5;