data = readmatrix('100M_20A.txt', 'NumHeaderLines', 1);
    
    t = data(:, 1)/2;
    y1 = data(:, 2); 
    y2 = data(:, 3);
    y = y1 + y2;

    h = plot( t, y, 'LineWidth',1.5,'Color',"black");

    xlabel('t (ns)', 'FontSize', 20, 'Interpreter', 'latex');
    ylabel('Ice molecules', 'FontSize', 20, 'Interpreter', 'latex');
    xlim([0 40])
    ylim([0 600])
    legend('100 MHz, 20 \AA','fontsize', 20,'interpreter','latex');
    legend boxoff
    set(gca,'fontsize', 20,'TickLabelInterpreter','latex');
    ax = gca;
    ax.LineWidth = 2;
    grid off;
    hold off;
