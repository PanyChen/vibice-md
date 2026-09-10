close all
clear all

modulus_data = load('equilTemp.txt');
y = modulus_data(:,1);
x = modulus_data(:,2);


X = [x, ones(size(x))];  


params = X \ y;
k = params(1);
b = params(2);

y_fit = X * params;


residuals = y - y_fit;
n = length(x);
p = 2;  


se = sqrt(sum(residuals.^2) / (n - p));


mdl = fitlm(x, y); 


x_range = linspace(min(x), max(x), 300)';
X_range = [x_range, ones(size(x_range))];
y_range_fit = X_range * params;

[y_fit, y_ci] = predict(mdl, x_range);


x_new = 17.9456;
x_err = 0.0783;
y_new = k * x_new + b;
y_err = k*0.0783;


x_new2 = 18.577249;
x_err2 = 0.135548573;
y_new2 = k * x_new2 + b;
y_err2 = k*0.135548573;


x_new3 = 19.2072;
x_err3 = 0.1893;
y_new3 = k * x_new3 + b;
y_err3 = k*0.1893;

% --- Plot ---
figure('Position', [100 100 600 400]);
hold on;
color_blue      = [0, 114, 178] / 255;
color_red       = [213, 94, 0]  / 255;
color_skyblue   = [86, 180, 233] / 255;
color_yellow = [0.9290 0.6940 0.1250];
color_green   = [0, 160, 0] / 255;

plot(x_range, y_range_fit, '-', 'Color', color_blue, 'LineWidth', 1.5, 'DisplayName', 'Linear fitting');

fill([x_range; flipud(x_range)], ...
     [y_ci(:,1); flipud(y_ci(:,2))], ...
     color_skyblue, 'FaceAlpha', 0.1, 'EdgeColor', 'none','DisplayName', '95\% confidence');


scatter(x, y, 100, 'MarkerFaceColor', color_skyblue, 'MarkerEdgeColor', [0 0.5 0.9], ...
    'MarkerFaceAlpha', 1, 'MarkerEdgeAlpha', 1, 'DisplayName', '${\rho}_{max}$ of water at $T_{eff}$');

errorbar(x_new3, y_new3, y_err3, '*','color', color_yellow, 'MarkerFaceColor',  color_yellow,'MarkerSize', 10,...
    'CapSize', 8, 'LineWidth', 1.5, 'DisplayName', '$T_{eff}$ ($I$ = 15 m/s)');


errorbar(x_new2, y_new2, y_err2, 'o','color', color_green, 'MarkerFaceColor',  color_green,'MarkerSize', 10,...
    'CapSize', 8, 'LineWidth', 1.5, 'DisplayName', '$T_{eff}$ ($I$ = 20 m/s)');


errorbar(x_new, y_new, y_err, 's','color', color_red, 'MarkerFaceColor',  color_red,'MarkerSize', 10,...
    'CapSize', 8, 'LineWidth', 1.5, 'DisplayName', '$T_{eff}$ ($I$ = 40 m/s)');


ylabel('$T_{eff}$ (K)', 'Interpreter', 'latex');
xlabel('${\rho}_{max}$ (nm$^{-2}$)', 'Interpreter', 'latex');
xl = xlim;
xticks(xl(1) : 1 : xl(2))
set(gca, 'fontsize', 20, 'TickLabelInterpreter', 'latex');
ax = gca;
ax.LineWidth = 1.5;
box on;
legend boxon;
legend('Interpreter', 'latex');
hold off;