clear all

data = [
    1      0
    1      0
    0.96   0.04
    0.675  0.325
    0.475  0.525
    0.35   0.65
    0.25   0.75
    0.175  0.825
    0.15   0.85
    0.125  0.875
    0.1    0.9
];
x1 = [0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1];

y1 = data(:, 1)';
y2 = data(:, 2)';
x2 = [0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1];
y3 = [0.954384423, 0.670861769, 0.476687662, 0.339028235, 0.244842687, 0.182839459, 0.142219023, 0.114832309, 0.095625273];

figure;
yyaxis left;

b = bar(x1, [y1; y2]', 0.8, 'stacked');
b(1).FaceColor = 'r'; 
b(2).FaceColor = 'b'; 


xlabel('${p}$','Interpreter','latex', 'FontSize', 12);
ylabel('${x_0}$','Interpreter','latex', 'FontSize', 12);
set(gca, 'FontName', 'Arial'); 
set(gca, 'FontSize', 14); 
box on;
ylim([0 1]); 
xlim([-0.1 1.1]);
yyaxis right;
hold on
plot(x2, y3, 'g-o', 'LineWidth', 2);
ylabel('${x^*}$','Interpreter','latex', 'FontSize', 12);
ylim([0, 1]);
