close all
clear all


modulus_data = readmatrix('modulus_data.txt','NumHeaderLines',1);
x_modulus = modulus_data(:,1)';
y_modulus = modulus_data(:,2)';
k = x_modulus(:) \ y_modulus(:);

y_fit = k * x_modulus;


residuals = y_modulus - y_fit;
n = length(x_modulus);
se = sqrt(sum(residuals.^2) / (n - 2));
alpha = 0.05;
t_val = tinv(1 - alpha/2, n - 1);
conf_interval = t_val * se / sqrt(n) ;


figure( 'Position', [10 10 600 500]);
hold on;
plot(x_modulus, y_fit, 'r--', 'LineWidth', 1, 'DisplayName', 'Bulk water'); % Fitted line
x_fill = [x_modulus, fliplr(x_modulus)];
y_fill = [y_fit - se, fliplr(y_fit + se)];
fill(x_fill, y_fill,'r', 'FaceAlpha', 0.1, 'EdgeColor', 'none','HandleVisibility', 'off');


% Load additional datasets
data_100 = load('100.txt');
data_250 = load('238.txt');
data_375 = load('352.txt');
data_500 = load('466.txt');
data_750 = load('691.txt');


x_100 = data_100(:,1) / 99.76;
y_100 = -data_100(:,2);

x_250 = data_250(:,1) / 237.6;
y_250 = -data_250(:,2);

x_375 = data_375(:,1) / 352.19;
y_375 = -data_375(:,2);

x_500 = data_500(:,1) / 466.14;
y_500 = -data_500(:,2);

x_750 = data_750(:,1) / 691.46;
y_750 = -data_750(:,2);
hold on;

plot(x_100, y_100, 's', 'LineWidth', 1.5,'MarkerSize', 20, 'DisplayName', '100 \AA');
plot(x_250, y_250, 'd', 'LineWidth', 1.5,'MarkerSize', 20, 'DisplayName', '238 \AA');
plot(x_375, y_375, '^', 'LineWidth', 1.5,'MarkerSize', 20, 'DisplayName', '352 \AA');
plot(x_500, y_500, 'v', 'LineWidth', 1.5,'MarkerSize', 20, 'DisplayName', '466 \AA');
plot(x_750, y_750, 'p', 'LineWidth', 1.5,'MarkerSize', 20, 'DisplayName', '691 \AA');

xlabel('$\varepsilon$','Interpreter','latex');
ylabel('$P_{mag}$ ($\sigma$) / MPa','Interpreter','latex');
xlim([0.03 0.09])
set(gca,'fontsize', 20,'TickLabelInterpreter','latex');
box on;
legend boxoff 
legend('Interpreter','latex')
hold off;