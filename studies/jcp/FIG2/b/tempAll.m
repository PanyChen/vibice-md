close all; clear;

dataFiles = {'static.txt', '10G10A.txt', '20G10A.txt', ...
             '20G20A.txt', '30G5A.txt', '30G10A.txt'};

labels = {'Static surface', '10 GHz, 10 \AA', '20 GHz, 10 \AA', ...
          '20 GHz, 20 \AA', '30 GHz, 5 \AA', '30 GHz, 10 \AA'};

smooth_window = 3000;

f = figure; hold on;
f.Position = [100 100 400 380];

if exist('temp.txt', 'file')
    delete('temp.txt');
end

for f = 1:length(dataFiles)

    filename = dataFiles{f};
    data = readmatrix(filename);

    if f == 1
        timestep = data(1:10:end, 1);
        temperature = data(1:10:end, 2);
    else
        timestep = data(:, 1);
        temperature = data(:, 2);
    end

    t0 = timestep(1);
    time = (timestep - t0) / 1000000;

    idx = time >= 0 & time <= 80;
    time_crop = time(idx);
    temp_crop = temperature(idx);

    avg_temp_smooth = movmean(temp_crop, smooth_window);
    ave_temp_one = mean(avg_temp_smooth);

    fileID = fopen('temp.txt', 'a');
    fprintf(fileID, '%.6f\n', ave_temp_one);
    fclose(fileID);

    plot(time_crop, avg_temp_smooth, 'LineWidth', 1.5);

end

legend(labels, ...
    'NumColumns', 2, ...
    'Interpreter', 'latex', ...
    'Location', 'best');

xlabel('$t$ (ns)', 'Interpreter', 'latex');
ylabel('$T_w$ (K)', 'Interpreter', 'latex');

legend boxoff;

ax = gca;
ax.TickLabelInterpreter = 'latex';
ax.FontSize = 20;
ax.LineWidth = 1.5;
grid off;
box on;