
vib10A = readmatrix("10G10A.txt",'FileType', 'text', 'NumHeaderLines', 2);
vib20A = readmatrix("20G20A.txt",'FileType', 'text', 'NumHeaderLines', 2);
static = readmatrix("static.txt",'FileType', 'text', 'NumHeaderLines', 2);



x_axis1 = (vib10A(:, 1)-vib10A(1,1))/1000000;
data_column1 = vib10A(:, 2);

x_axis2 = (vib20A(:, 1)-vib20A(1,1))/1000000; 
data_column2 = vib20A(:, 2); 

x_axis3 = (static(1:10:end, 1)-static(1, 1))/1000000; 
data_column3 = static(1:10:end, 2); 

window_size = 200; 


filtered_data1 = movmean(data_column1, window_size);
filtered_data2 = movmean(data_column2, window_size);
filtered_data3 = movmean(data_column3, window_size);
f = figure;
f.Position = [100 100 400 380];


plot(x_axis1, filtered_data1, 'LineWidth',2);
hold on
plot(x_axis2, filtered_data2, 'LineWidth',2)
hold on
plot(x_axis3, filtered_data3, 'LineWidth',2)
hold on
yline(237,'--', 'LineWidth', 3, 'Color', 'r')

legend('$I=$ 10 m/s', '$I=$ 40 m/s','Static surface','interpreter','latex');
legend boxoff;
xlabel('$t$ (ns)','interpreter','latex');
ylabel('$T_w$ (K)','interpreter','latex');
ylim([230 245])
xlim([0 50])

ax = gca;
ax.TickLabelInterpreter = 'latex';
ax.FontSize = 20;
ax.LineWidth = 1.5;
