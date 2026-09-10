x = [0, 10,40];
q_mean = [0.561989953,0.559203445,0.520321871];
q_se = [0.001078497,0.00057414,0.001108622];

figure;

hold on;

errorbar(x, q_mean, q_se, 'o-',...
    'LineWidth', 2, ...
    'CapSize', 12);

xlabel('$I$ (m/s)', 'Interpreter','latex');
ylabel('$\langle q \rangle$', 'Interpreter','latex');

xticks(x);
xlim([-10, 50]);


ymin = min(q_mean - q_se);
ymax = max(q_mean + q_se);
padding = 0.2 * (ymax - ymin);

ylim([ymin - padding, ymax + padding]);


ax = gca;
ax.FontSize = 20;
ax.TickLabelInterpreter = 'latex';
ax.LineWidth = 1.5;
box on;

set(gcf, 'Position', [100, 100, 450, 400]);