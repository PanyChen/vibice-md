clear; clc; close all;


data = dlmread('combined_data_25.txt', ' ', 1, 0);

time = data(:, 1) / 40;          
y = data(:, 3);                 
z = data(:, 4);                  
size_values = data(:, 2) * 50;  


idx_even = mod(data(:, 1), 2) == 0;

time = time(idx_even);
y = y(idx_even);
z = z(idx_even);
size_values = size_values(idx_even);

figure;


scatter(y, z, size_values, time, ...
        'filled', ...
        'MarkerEdgeColor', 'black');


xlim([0, 82.7316]);
ylim([0, 85.977]);


clim([0 10]);

cb = colorbar('TickLabelInterpreter', 'latex');
colormap(slanCM('Blues'));


cb.FontSize = 20;
cb.LineWidth = 1.5;


cb.Label.String = 'Time (ns)';
cb.Label.Interpreter = 'latex';
cb.Label.FontSize = 20;


cb.Label.Rotation = -90;
cb.Label.VerticalAlignment = 'bottom';


cb.Label.Position(1) = cb.Label.Position(1);


xlabel('Y coordinate (\AA)', ...
       'Interpreter', 'latex', ...
       'FontSize', 20);

ylabel('Z coordinate (\AA)', ...
       'Interpreter', 'latex', ...
       'FontSize', 20);


ax = gca;
ax.FontSize = 20;
ax.TickLabelInterpreter = 'latex';
ax.LineWidth = 1.5;
box on;

set(gcf, 'Position', [100, 100, 450, 400]);