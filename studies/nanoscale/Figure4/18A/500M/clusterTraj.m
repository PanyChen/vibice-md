data = dlmread('combined_data_25.txt', ' ', 1, 0);


cluster = (data(:, 1)+1);
y = data(:, 3);    
z = data(:, 4);    
size_values = data(:, 2) * 100; 

figure;

scatter(y, z, size_values, cluster/2, 'filled');
xlim([-10,90]);
ylim([-10,90]);
clim([0 70]);
colorbar('TickLabelInterpreter', 'latex');
colormap(parula);
xlabel('x dimension (\AA)','Interpreter', 'latex','FontSize', 20);
ylabel('y dimension (\AA)','Interpreter', 'latex','FontSize', 20);
set(gca,'fontsize', 20,'TickLabelInterpreter', 'latex','box', 'on');
set(gcf, 'Position', [100, 100, 450, 400]);
