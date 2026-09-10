
data1 = load('water.txt');
data2 = load('ice.txt');


x1 = data1(:,1)-5.04999; %%from the surface
y1 = data1(:,2);
x2 = data2(:,1)-5.04999;
y2 = data2(:,2);

figure;
plot(x1, y1, 'LineWidth', 1.5); hold on;
plot(x2, y2, 'LineWidth', 1.5);
hold off;

legend('Water', 'Ice', 'Interpreter', 'latex','FontSize', 20);
legend boxoff;
xlabel( 'Distance from surface (\AA)', 'Interpreter', 'latex','FontSize', 20);
ylabel( '${\rho}$ (g/cm$^3$)', 'Interpreter', 'latex' ,'FontSize', 20);
xlim([0 25])
ax = gca;
ax.TickLabelInterpreter = 'latex';
ax.FontSize = 20;
ax.LineWidth=1.5;
grid off;