clear all

data = [
    1      0
    1      0
    1      0
    0.725  0.275
    0.375  0.625
    0.175  0.825
    0.02   0.98
    0      1
    0      1
    0      1
    0      1
];
x1 = [0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1];

y1 = data(:, 1)';
y2 = data(:, 2)';
x2 = [0.3, 0.4, 0.5, 0.6];
y3 = [0.694227825, 0.384919422, 0.176693398, 0.045698593];

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
