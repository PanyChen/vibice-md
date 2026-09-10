clear; clc; close all;

data = readmatrix('density.txt');

y = data(:,1);
z = data(:,2);
dens = data(:,6);

numSlicesY = 10;
numSlicesZ = 18;

yEdges = linspace(min(y), max(y), numSlicesY + 1);
zEdges = linspace(min(z), max(z), numSlicesZ + 1);

ny = 100;
nz = 100;
sumGrid = zeros(nz, ny);
nValid = 0;

for i = 1:numSlicesY
    for j = 1:numSlicesZ

        inY = y >= yEdges(i) & y < yEdges(i+1);
        inZ = z >= zEdges(j) & z < zEdges(j+1);
        inSlice = inY & inZ;

        if ~any(inSlice)
            continue;
        end

        ySlice = y(inSlice);
        zSlice = z(inSlice);
        densSlice = dens(inSlice);

        [Yg, Zg] = meshgrid( ...
            linspace(yEdges(i), yEdges(i+1), ny), ...
            linspace(zEdges(j), zEdges(j+1), nz));

        densGrid = griddata(ySlice, zSlice, densSlice, Yg, Zg, 'nearest');

        if all(isnan(densGrid(:)))
            continue;
        end

        sumGrid = sumGrid + densGrid;
        nValid = nValid + 1;

    end
end

aveGrid = sumGrid / nValid;

[Yplot, Zplot] = meshgrid( ...
    linspace(0, yEdges(2) - yEdges(1), ny), ...
    linspace(0, zEdges(2) - zEdges(1), nz));

figure;
contourf(Yplot, Zplot, aveGrid, 15, 'LineColor', 'none');

colormap(slanCM('ice'));
clim([8 18]);
colorbar;

xlabel('Y coordinate (\AA)', 'Interpreter', 'latex');
ylabel('Z coordinate (\AA)', 'Interpreter', 'latex');

ax = gca;
ax.TickLabelInterpreter = 'latex';
ax.FontSize = 25;
ax.LineWidth = 1.5;

[Vmax, idx] = max(aveGrid(:));
fprintf('Maximum \\rho is %.6f\n', Vmax);