data = readmatrix("meas_final.txt","NumHeaderLines",2);

time = (data(:, 1)-18400000)/200000;
pressure = data(:, 5)*6947.6955/7437.3376;
window_size = 500; 
average = movmean(pressure, window_size);

plot(time,average, 'black-', 'LineWidth',2);
legend('50 MHz, 14 \AA', 'Static','interpreter','latex');
xlabel('t (ns)','interpreter','latex');
ylabel('$P_{loc}$ (MPa)','interpreter','latex');
ylim([-340 420])
legend boxoff
ax = gca;
ax.TickLabelInterpreter = 'latex';
ax.FontSize = 30;
