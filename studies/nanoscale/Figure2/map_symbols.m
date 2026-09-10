% Read the data from the Excel file
filename = 'regime_map.xlsx'; % Replace with your actual file name
data = readmatrix(filename);

% Extract frequencies and amplitudes from the data
frequencies = data(1, 2:end); 
amplitudes = data(2:end, 1); 
regimeData = data(2:end, 2:end); 

% Check dimensions
numFrequencies = length(frequencies);
numAmplitudes = length(amplitudes);
[dataRows, dataCols] = size(regimeData);

if numFrequencies ~= dataCols || numAmplitudes ~= dataRows
    error('Mismatch between the dimensions of frequencies/amplitudes and regimeData');
end

% Define the marker symbols for each type of value
colors = {[94 167 184], [48 129 146], [241 204 116], [227 141 38], [199 77 38]};
symbols = {'o', 's', 'D', '^', '<'};
markerSize = 500; % Adjust the marker size for the legend

% Create a figure
figure;
hold on;

% Overlay scatter plot for each value with a different symbol
for value = 0:4
    [row, col] = find(regimeData == value);
    scatter(frequencies(col), amplitudes(row), symbols{value+1},'filled','DisplayName', sprintf('Value %d', value), 'SizeData', markerSize, 'Markerfacecolor', colors{value+1}/255,'MarkerEdgeColor','black');
end

xlabel('f (MHz)','Interpreter','latex');
ylabel('a (\AA)','Interpreter','latex');
xlim([min(frequencies), max(frequencies)]);
ylim([min(amplitudes), max(amplitudes)]);
set(gca, 'ytick', 8:5:30);
width = 10;  
height = 7.8;
set(gcf, 'Units', 'inches', 'Position', [1, 1, width, height]); 
set(gcf, 'PaperPositionMode', 'auto');
set(gca,'fontsize', 20,'TickLabelInterpreter','latex');
box on;
hold off;
export_fig('transparent_figure.png', '-png', '-transparent','-r900');