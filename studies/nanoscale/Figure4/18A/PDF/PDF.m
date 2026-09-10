
filenames = {'125.txt', '250.txt', '500.txt'};

data_all = cell(1, length(filenames));

for i = 1:length(filenames)
    data = readmatrix(filenames{i}, 'Delimiter', ' ', 'NumHeaderLines', 1);
    filtered_data = data(all(data ~= 0, 2), :);
    data_all{i} = filtered_data(:, 2); 
end

lowerBound = 0; 
upperBound = 60; 
numBins = 30;  
binEdges = linspace(lowerBound, upperBound, numBins+1);

figure;
hold on;
color1 = [0 91 154];
color2 = [1 145 200];
color3 = [166 194 225];
colors = {color1, color2,color3};
labels = {'iii', 'iv', 'v'};

% Plot histograms
for i = 1:length(filenames)
    subplot(3,1,i);
    h = histogram(data_all{i}, 'BinEdges', binEdges, 'Normalization', 'pdf', 'FaceAlpha', 1, 'DisplayName', labels{i});
    h.FaceColor = colors{i}/255;
set(gca,'YLabel',[], 'XLabel',[]);
xticks(12:8:60)
xlim([12, 60]);
ylim([0, 0.055]);
lgd = legend(labels{i}, 'Location', 'northeast', 'Interpreter', 'latex', 'FontSize', 30);
legend boxoff   
set(gca, 'FontSize', 20, 'TickLabelInterpreter', 'latex', 'Box', 'on');
set(gcf, 'Position', [100, 100, 450, 400]);
    hold on
end
xlabel('Cluster size (No. of molecules)', 'Interpreter', 'latex', 'FontSize', 20);
ylabel('Probability Density', 'Interpreter', 'latex', 'FontSize', 20);
grid off;

% Save the figure
saveas(gcf, "combined_histograms.png");