
f = figure;
f.Position = [100 100 400 350];

x = [0,5,10,15,15, 20,20,30,30,40];
y = [234.84,234.43 235.11, 234.68,234.37,232.97,234.30,232.93,233.16,232.44 ];
std = [2.03,0.77, 1.76, 1.96,2.00,1.13,1.41,1.59,1.68,2.07]; 
err = std/sqrt(5); % error bars

colors = lines(length(x));

hold on;

for i = 1:length(x)
    errorbar(x(i), y(i), err(i), 'o', ...
        'Color', colors(1,:), ...
        'MarkerFaceColor', colors(1,:), ...
        'MarkerSize', 8, ...
        'LineWidth', 1.5, ...
        'CapSize', 8);
end

p = polyfit(x,y,1);   
y_fit = polyval(p,x);


[x_sorted, idx] = sort(x);
y_fit_sorted = y_fit(idx);


SSres = sum((y - y_fit).^2);
SStot = sum((y - mean(y)).^2);
R2 = 1 - SSres/SStot;


RMSE = sqrt(mean((y - y_fit).^2));

fprintf('R^2 = %.4f\n', R2);
fprintf('RMSE = %.4f\n', RMSE);

plot(x_sorted, y_fit_sorted, '--r', 'LineWidth', 1.5);
legend off;

xlabel('$I$ (m/s)','interpreter','latex');
ylabel('$T_{N}$ (K)','interpreter','latex');
xlim([0 40])

box on;

ax = gca;
ax.TickLabelInterpreter = 'latex';
ax.FontSize = 20;
ax.LineWidth = 1.5;

fprintf('Linear fit: y = %.4f * x + %.4f\n', p(1), p(2));

hold off;
