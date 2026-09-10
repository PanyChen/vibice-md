colors = [
    0.000, 0.447, 0.698;  
    0.906, 0.298, 0.235;  
    0.000, 0.620, 0.451;  
];
list=load('static.txt');
    [xData, yData] = prepareCurveData( list(:,1), list(:,2) );

ft = fittype( 'exp(-(a*xData))', 'independent', 'xData', 'dependent', 'yData' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.Lower = 0;
opts.StartPoint = 0.05;
opts.Upper = 0.5;

f=figure;
f.Position = [100 100 400 380];

[fitresult, gof] = fit( xData, yData, ft, opts );

h = plot( fitresult, xData, yData);
hold on; 
g = plot(xData, yData, '.', 'MarkerSize', 30,'MarkerFaceColor', colors(1, :),'MarkerEdgeColor', colors(1, :),'LineStyle', 'none',  'DisplayName', 'Case 1: Static surface');
set(h, 'LineWidth', 2,'Color',colors(1, :));
hold on;

%%%%%%%%%%%%%%%%%%%

list=load('10G10A.txt');
    [xData1, yData1] = prepareCurveData( list(:,1), list(:,2) );


ft = fittype( 'exp(-(a*xData))', 'independent', 'xData', 'dependent', 'yData' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.Lower = 0;
opts.StartPoint = 0.05;
opts.Upper = 0.5;


[fitresult1, gof] = fit( xData1, yData1, ft, opts );

h1 = plot( fitresult1, xData1, yData1);
hold on; 
g1 = plot(xData1, yData1, '.', 'MarkerSize', 30,'MarkerFaceColor', colors(2, :),'MarkerEdgeColor', colors(2, :),'MarkerFaceColor','blue', 'LineStyle', 'none','DisplayName', 'Case 2: $I=$ 10 m/s');
set(h1, 'LineWidth', 2,'color',colors(2, :)); 
hold on;

%%%%%%%%%%%%%%%%%

list=load('20G20A.txt');
    [xData2, yData2] = prepareCurveData( list(:,1), list(:,2) );

ft = fittype( 'exp(-(a*xData))', 'independent', 'xData', 'dependent', 'yData' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.Lower = 0;
opts.StartPoint = 0.05;
opts.Upper = 0.5;


[fitresult2, gof] = fit( xData2, yData2, ft, opts );

h2 = plot( fitresult2, xData2, yData2);
hold on; 
g2 = plot(xData2, yData2, '.', 'MarkerSize', 30,'MarkerFaceColor', colors(3, :),'MarkerEdgeColor', colors(3, :),'MarkerFaceColor','green', 'LineStyle', 'none','DisplayName', 'Case 3: $I=$ 40 m/s');
set(h2, 'LineWidth', 2,'color', colors(3, :)); 
legend([g, g1,g2], 'Location', 'best','Interpreter','latex');

set(legend, 'FontSize', 15);

xlabel( '$t$ (ns)', 'Interpreter', 'latex','FontSize', 20);
ylabel( '$P(t)$', 'Interpreter', 'latex' ,'FontSize', 20);
ylim([0 1])
ax = gca;
ax.TickLabelInterpreter = 'latex';
ax.FontSize = 20;
ax.LineWidth = 1.5;
hold on;

