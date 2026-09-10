static = readmatrix("static.txt",'FileType', 'text', 'NumHeaderLines', 2);
I10 = readmatrix("I10.txt",'FileType', 'text', 'NumHeaderLines', 2);
I15 = readmatrix("I15.txt",'FileType', 'text', 'NumHeaderLines', 2);
I20 = readmatrix("I20.txt",'FileType', 'text', 'NumHeaderLines', 2);
I30 = readmatrix("I30.txt",'FileType', 'text', 'NumHeaderLines', 2);
I40 = readmatrix("I40.txt",'FileType', 'text', 'NumHeaderLines', 2);

static_bin_centers = static(:,1);
static_pdf_values  = static(:,2);
I10_bin_centers = I10(:,1);
I10_pdf_values  = I10(:,2);
I15_bin_centers = I15(:,1);
I15_pdf_values  = I15(:,2);
I20_bin_centers = I20(:,1);
I20_pdf_values  = I20(:,2);
I30_bin_centers = I30(:,1);
I30_pdf_values  = I30(:,2);
I40_bin_centers = I40(:,1);
I40_pdf_values  = I40(:,2);

figure('Position', [100 100 420 400]);
t = tiledlayout(6,1);
t.TileSpacing = 'compact';
t.Padding = 'compact';
ylabel(t,'Probability density','Interpreter','latex','FontSize',25);

defaultColors = [
    0.0000 0.4470 0.7410
    0.8500 0.3250 0.0980
    0.9290 0.6940 0.1250
    0.4940 0.1840 0.5560
    0.4660 0.6740 0.1880
    0.3010 0.7450 0.9330
    0.6350 0.0780 0.1840
];

darkColors = [
    0.55 0.75 1.00   % light sky blue
    1.00 0.60 0.60   % soft coral
    1.00 0.85 0.45   % bright pastel orange
    0.80 0.65 1.00   % light lavender
    0.60 0.90 0.60   % fresh light green
    0.55 0.95 0.95   % bright cyan
    1.00 0.65 0.85   % pink
];
ax1 = nexttile;
b1 = bar(static_bin_centers, static_pdf_values, 1.0);
b1.FaceColor = defaultColors(1,:);
ylim([0 0.6]); box on
set(ax1,'FontSize',20,'TickLabelInterpreter','latex')
legend('$I=$ 0 m/s','interpreter','latex');legend boxoff;ax = gca;ax.LineWidth = 1.5;xlim([1 8])
hold on;
xline(4.8919125,':k','LineWidth',3,'HandleVisibility','off')
xticks([]);

ax2 = nexttile;
b2 = bar(I10_bin_centers, I10_pdf_values, 1.0);
b2.FaceColor = defaultColors(2,:);
ylim([0 0.6]); box on
set(ax2,'FontSize',20,'TickLabelInterpreter','latex')
legend('$I=$ 10 m/s','interpreter','latex');legend boxoff;ax = gca;ax.LineWidth = 1.5;xlim([1 8])
hold on;
xline(5.053350000000000,':k','LineWidth',3,'HandleVisibility','off')
xticks([]);

ax3 = nexttile;
b3 = bar(I15_bin_centers, I15_pdf_values, 1.0);
b3.FaceColor = defaultColors(3,:);
ylim([0 0.6]); box on
set(ax3,'FontSize',20,'TickLabelInterpreter','latex')
legend('$I=$ 15 m/s','interpreter','latex');legend boxoff;ax = gca;ax.LineWidth = 1.5;xlim([1 8])
hold on;
xline(5.010893000000001,':k','LineWidth',3,'HandleVisibility','off')
xticks([]);


ax4 = nexttile;
b4 = bar(I20_bin_centers, I20_pdf_values, 1.0);
b4.FaceColor = defaultColors(4,:);
ylim([0 0.6]); box on
set(ax4,'FontSize',20,'TickLabelInterpreter','latex')
legend('$I=$ 20 m/s','interpreter','latex');legend boxoff;ax = gca;ax.LineWidth = 1.5;xlim([1 8])
hold on;
xline(4.926439000000000,':k','LineWidth',3,'HandleVisibility','off')
xticks([]);

ax5 = nexttile;
b5 = bar(I30_bin_centers, I30_pdf_values, 1.0);
b5.FaceColor = defaultColors(5,:);
ylim([0 0.6]); box on
set(ax5,'FontSize',20,'TickLabelInterpreter','latex')
legend('$I=$ 30 m/s','interpreter','latex');legend boxoff;ax = gca;ax.LineWidth = 1.5;xlim([1 8])
hold on;
xline(4.841371000000001,':k','LineWidth',3,'HandleVisibility','off')
xticks([]);

ax6 = nexttile;
b6 = bar(I40_bin_centers, I40_pdf_values, 1.0);
b6.FaceColor = defaultColors(6,:);
ylim([0 0.6]); box on
set(ax6,'FontSize',20,'TickLabelInterpreter','latex')
legend('$I=$ 40 m/s','interpreter','latex');legend boxoff;ax = gca;ax.LineWidth = 1.5;xlim([1 8])
hold on;
xline(4.608438000000000,':k','LineWidth',3,'HandleVisibility','off')


xlabel('$\bar t_{r}$ (ps)','Interpreter','latex','FontSize',25)
box on

ax = gca;
ax.TickLabelInterpreter = 'latex';
ax.FontSize = 20;
ax.LineWidth = 3;
ax = findall(gcf,'Type','axes');
set(ax,'LineWidth',1.5,'Box','on','Layer','top')
set(gcf,'Renderer','painters')
