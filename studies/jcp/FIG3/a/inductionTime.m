close all; clear; clc;

data = readmatrix('ramp.txt');

xData = (data(100:end, 1) - data(1, 1) + 1000) / 1000000;
yData = data(100:end, 2);

ySmooth = smooth(xData, yData, 1000, 'loess');
dy = gradient(ySmooth, xData);

window = 500;
t0 = NaN;
temp = NaN;

for i = window+1:length(ySmooth)-window
    if dy(i+window) > 15
        t0 = xData(i);
        temp = ySmooth(i);
        break
    end
end

f = figure;
f.Position = [100 100 400 350];

subplot(2,1,1);
plot(xData, yData, '.', xData, ySmooth, 'k-', 'LineWidth', 1.2);
xline(t0, 'r--', 'LineWidth', 2);
ylabel('$T$ (K)', 'FontSize', 20, 'Interpreter', 'latex');
set(gca, 'XTickLabel', []);
legend('Static surface', 'FontSize', 20, 'Interpreter', 'latex');
legend boxon;
xlim([0 70]);
box on;

ax = gca;
ax.TickLabelInterpreter = 'latex';
ax.FontSize = 20;
ax.LineWidth = 1.5;

subplot(2,1,2);
plot(xData, dy, 'k-', 'LineWidth', 1);
xline(t0, 'r--', 'LineWidth', 2);
ylabel('$\displaystyle \frac{dT}{dt}$ (K$\cdot$ns$^{-1}$)', ...
    'FontSize', 20, 'Interpreter', 'latex');
xlabel('$t$ (ns)', 'FontSize', 20, 'Interpreter', 'latex');
xlim([0 70]);
box on;

ax = gca;
ax.TickLabelInterpreter = 'latex';
ax.FontSize = 20;
ax.LineWidth = 1.5;

fprintf('Detected drop onset = %.2f ns\n', t0);
fprintf('Nucleation temperature = %.2f K\n', temp);