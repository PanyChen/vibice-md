
filename = 'scaling_data.xlsx';
data = readmatrix(filename);


thicknesses = data(1, 2:end);
amplitudes = data(2:end, 1); 
regimeData = data(2:end, 2:end); 

% Check dimensions
numFrequencies = length(thicknesses);
numAmplitudes = length(amplitudes);
[dataRows, dataCols] = size(regimeData);

if numFrequencies ~= dataCols || numAmplitudes ~= dataRows
    error('Mismatch between the dimensions of thicknesses/amplitudes and regimeData');
end

regimeData(isnan(regimeData)) = 100;

symbols = {'o', 'D', 'v', '^', 's'};
markerSize = 100;

% Create a figure
figure;
hold on;

for value = 0:4
    [row, col] = find(regimeData == value);
    scatter(thicknesses(col), amplitudes(row), symbols{value+1}, 'filled','DisplayName', sprintf('Value %d', value), 'SizeData', markerSize, 'MarkerEdgeColor','black');
end

xlabel('$h_{w}$ (\AA)','Interpreter','latex');
ylabel('$\varepsilon$','Interpreter','latex');
xlim([99,700]);
set(gca,'XTick',(100:200:750))
ylim([0, max(amplitudes)]);
yline(0.09, '--', 'Color', 'k');


yline(0.04, '--', 'Color', 'k');
text(550, 0.09, '$\varepsilon=0.09$', 'Interpreter', 'latex', ...
     'FontSize', 20, 'HorizontalAlignment', 'left', 'VerticalAlignment', 'bottom');
text(550, 0.04, '$\varepsilon=0.04$', 'Interpreter', 'latex', ...
     'FontSize', 20, 'HorizontalAlignment', 'left', 'VerticalAlignment', 'bottom');

set(gca,'fontsize', 20,'TickLabelInterpreter','latex');
box on;
hold off;