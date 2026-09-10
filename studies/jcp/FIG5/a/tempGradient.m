clear; clc; close all;

dataFiles = {"static.txt", "10G10A.txt", "20G20A.txt"};

labels = {'Static surface', '$I$ = 10 m/s', '$I$ = 40 m/s'};

nF = numel(dataFiles);

allX = cell(nF,1);
allTemp = cell(nF,1);

for i = 1:nF

    fpath = dataFiles{i};

    if ~isfile(fpath)
        error("File not found: %s", fpath);
    end

    T = readtable(fpath, ...
        "FileType", "text", ...
        "Delimiter", "\t", ...
        "VariableNamingRule", "preserve");

    x = T{:,1};
    temp = T{:,3};

    [x, idx] = sort(x);
    temp = temp(idx);

    allX{i} = x;
    allTemp{i} = temp;

end

f = figure('Color','w');
f.Position = [100 100 400 300];

hold on; grid off; box on;

for i = 1:nF
    plot(allX{i}, allTemp{i}, 'LineWidth', 1.5);
end

xlabel('Distance from surface (\AA)', ...
    'FontSize', 20, ...
    'Interpreter', 'latex');

ylabel('$T_{w}$ (K)', ...
    'FontSize', 20, ...
    'Interpreter', 'latex');

legend(labels, ...
    'Interpreter', 'latex', ...
    'Location', 'best');

ax = gca;
ax.TickLabelInterpreter = 'latex';
ax.FontSize = 20;
ax.LineWidth = 1.5;

xlim([0 65]);
