clear; clc; close all;

dataFiles = {'static.txt', '20G20A.txt'};
legends = {'Static surface', '$I =$ 40 m/s'};

figure;
hold on;

for k = 1:numel(dataFiles)

    data = readmatrix(dataFiles{k});

    y = data(:,1);
    z = data(:,2);
    dens = data(:,6);

    numSlicesy = 10;
    numSlicesz = 18;

    yEdges = linspace(min(y), max(y), numSlicesy + 1);
    zEdges = linspace(min(z), max(z), numSlicesz + 1);

    ny = 100;
    nz = 100;
    sumGrid = zeros(ny);

    for i = 1:numSlicesy
        for j = 1:numSlicesz

            inY = y >= yEdges(i) & y < yEdges(i+1);
            inZ = z >= zEdges(j) & z < zEdges(j+1);
            inSlice = inY & inZ;

            if ~any(inSlice)
                continue;
            end

            ySlice = y(inSlice);
            zSlice = z(inSlice);
            densSlice = dens(inSlice);

            yMinLocal = yEdges(i);
            yMaxLocal = yEdges(i+1);
            zMinLocal = zEdges(j);
            zMaxLocal = zEdges(j+1);

            yMinLocal1 = yEdges(1);
            yMaxLocal1 = yEdges(2);
            zMinLocal1 = zEdges(1);
            zMaxLocal1 = zEdges(2);

            [Yg, Zg] = meshgrid(linspace(yMinLocal, yMaxLocal, ny), ...
                                linspace(zMinLocal, zMaxLocal, nz));

            [Yg1, Zg1] = meshgrid(linspace(yMinLocal1, yMaxLocal1, ny), ...
                                  linspace(zMinLocal1, zMaxLocal1, nz));

            Yg_norm = Yg1 - min(Yg1(:));
            Zg_norm = Zg1 - min(Zg1(:));

            densGrid = griddata(ySlice, zSlice, densSlice, Yg, Zg, 'nearest');

            sumGrid = sumGrid + densGrid;

        end
    end

    aveGrid = sumGrid / 180;

    [~, idx] = max(aveGrid(:));
    [row, ~] = ind2sub(size(aveGrid), idx);

    top3 = maxk(aveGrid(:), 3);
    peak_avg = mean(top3);
    fprintf('%s: Maximum \\rho is %.2f\n', legends{k}, peak_avg);

    h = plot(Yg_norm(1,:), aveGrid(row,:), 'LineWidth', 3);
    h.DisplayName = legends{k};

end

xlabel('Y coordinate (\AA)', 'Interpreter', 'latex');
ylabel('${\rho}$ (\AA$^{-2}$)', 'Interpreter', 'latex');

xlim([0 8]);

ax = gca;
ax.TickLabelInterpreter = 'latex';
ax.FontSize = 20;
ax.LineWidth = 1.5;
grid off;
box on;

lgd = legend(ax, 'show', 'Location', 'best', 'Interpreter', 'latex');
lgd.Box = 'off';