
f = figure;


errorbar(0,0.035734, 0.004666, 0.004666, '.', 'MarkerSize', 20);
hold on;
errorbar(10,0.018284 ,0.003568,0.003568, '.', 'MarkerSize', 20);
hold on;
errorbar(20,0.009849, 0.000646, 0.000646, '.', 'MarkerSize', 20);
hold on;
errorbar(40,0,0,0, '.', 'MarkerSize', 20);
hold on;
errorbar(15,0.001439 ,0.000080,0.000080, '.', 'MarkerSize', 20);
hold on;
errorbar(30,0,0,0, '.', 'MarkerSize', 20);
hold on;

f.Position = [100 100 400 350];
legend('Static surface', '10 GHz, 10 \AA','20 GHz, 10 \AA','20 GHz, 20 \AA','30 GHz, 5 \AA','30 GHz, 10 \AA','interpreter','latex');
xlabel('$I$ (m/s)','interpreter','latex');
ylabel('$J$ (ns$^{-1}$)','interpreter','latex');
xlim([0 40])
box on;

ax = gca;
ax.TickLabelInterpreter = 'latex';
ax.FontSize = 20;
ax.LineWidth = 1.5;
hold off;
