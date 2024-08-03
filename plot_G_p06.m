clear all

r = 5;
delta = 0.4;
p = 0.6;
k_values = 2:0.001:12;


first_zeros = [];
second_zeros = [];

x_range = linspace(0.01, 0.99, 10000);
G_values = 2:0.001:12;
first_zeros1 = [];
second_zeros1 = [];

colors = {'r', 'b'};
line_widths = [2,1];


for k_idx = 1:length(k_values)
    k = k_values(k_idx);
    previous_f_value = NaN;
    current_zero_points = [];
    zeros_x = [];

    for i = 2:length(x_range)
        
        x=x_range(i);

        lam1 = p * (1 + delta) * (1 + (((k - 2) * x + 1) / (k - 1)) * delta)^(k - 1);
        lam2 = p * (1 + (((k - 2) * x) / (k - 1)) * delta)^(k - 1);
        lam3 = (1 - p) * (1 - delta) * (1 - (((k - 2) * x + 1) / (k - 1)) * delta)^(k - 1);
        lam4 = (1 - p) * (1 - (((k - 2) * x) / (k - 1)) * delta)^(k - 1);
        phi1 = (r / ((k + 1) * delta)) * (((k-2)*x+1)*((1 + delta) * (lam1 - lam2) - (1 - delta) * (lam3 - lam4)) + (lam1 - lam2 - lam3 + lam4) + delta * (k - 1) * (lam2 + lam4)) - (k + 1);
        phi2 = (r / ((k + 1) * delta)) * (lam1 - lam2 - lam3 + lam4);
        phi3 = (r / ((k + 1) * delta)) * ((k - 2) * x * (lam1 - lam2 - lam3 + lam4) - delta * (k - 1) * (lam2 + lam4)) + k + 1;
        phi4 = (r / ((k + 1) * delta)) * ((1 + delta) * (lam1 - lam2) - (1 - delta) * (lam3 - lam4));
        f = x * (1 - x) * (phi1 - phi2 - phi3 + phi4 - (k - 2) * x * (phi2 - phi4));
        
        x1=x_range(i-1);
        lam11 = p * (1 + delta) * (1 + (((k - 2) * x1 + 1) / (k - 1)) * delta)^(k - 1);
        lam21 = p * (1 + (((k - 2) * x1) / (k - 1)) * delta)^(k - 1);
        lam31 = (1 - p) * (1 - delta) * (1 - (((k - 2) * x1 + 1) / (k - 1)) * delta)^(k - 1);
        lam41 = (1 - p) * (1 - (((k - 2) * x1) / (k - 1)) * delta)^(k - 1);
        phi11 = (r / ((k + 1) * delta)) * (((k-2)*x1+1)*((1 + delta) * (lam11 - lam21) - (1 - delta) * (lam31 - lam41)) + (lam11 - lam21 - lam31 + lam41) + delta * (k - 1) * (lam21 + lam41)) - (k + 1);
        phi21 = (r / ((k + 1) * delta)) * (lam11 - lam21 - lam31 + lam41);
        phi31 = (r / ((k + 1) * delta)) * ((k - 2) * x1 * (lam11 - lam21 - lam31 + lam41) - delta * (k - 1) * (lam21 + lam41)) + k + 1;
        phi41 = (r / ((k + 1) * delta)) * ((1 + delta) * (lam11 - lam21) - (1 - delta) * (lam31 - lam41));
        f1 =  (phi11 - phi21 - phi31 + phi41 - (k - 2) * x1 * (phi21 - phi41));
        
        if f * f1 < 0
            zeros_x = [zeros_x, x_range(i)];
        end
    end
    if length(zeros_x) == 1
        second_zeros = [second_zeros; k zeros_x];
    elseif length(zeros_x) > 1
        first_zeros = [first_zeros; k zeros_x(1)];
        second_zeros = [second_zeros; k zeros_x(2)];
    end
end



for G_idx = 1:length(G_values)
    G = G_values(G_idx);
    f_values = x_range .* (1 - x_range) .* tanh(((r / G) * (p * (1 + delta * x_range) .^ (G - 1) + (1 - p) * (1 - delta * x_range) .^ (G - 1)) - 1) * 0.005);
    zeros_x = [];
    for i = 2:length(x_range)
        if f_values(i-1) * f_values(i) < 0
            zeros_x = [zeros_x, x_range(i)];
        end
    end
    if length(zeros_x) == 1
        second_zeros1 = [second_zeros1; G zeros_x];
    elseif length(zeros_x) > 1
        first_zeros1 = [first_zeros1; G zeros_x(1)];
        second_zeros1 = [second_zeros1; G zeros_x(2)];
    end
end

first_zeros2=first_zeros;
second_zeros2=second_zeros;

for i=1:length(first_zeros)
    first_zeros2(i,1)=first_zeros(i,1)+1;
end


for i=1:length(second_zeros)
    second_zeros2(i,1)=second_zeros(i,1)+1;
end



N = size(second_zeros1, 1);
part1 = second_zeros1(1:100, :);
indices = 101:100:N;
part2 = second_zeros1(indices, :);
result1 = [part1; part2];

N = size(second_zeros2, 1);
part1 = second_zeros2(1:100, :);
indices = 101:100:N;
part2 = second_zeros2(indices, :);
result2 = [part1; part2];

figure('Position', [360, 534, 276, 238]);

hold on;
if ~isempty(first_zeros1)
    plot(first_zeros1(:,1), first_zeros1(:,2), 'r-', 'LineWidth', 2, 'HandleVisibility','off'); % 实线表示有两个零点的第一个值
end
if ~isempty(second_zeros1)
    plot(result1(:,1), result1(:,2), 'r--', 'LineWidth', 2, 'HandleVisibility','off'); % 虚线表示只有一个零点的值与有两个零点的第二个值
end

if ~isempty(first_zeros2)
    plot(first_zeros2(:,1), first_zeros2(:,2), 'b-', 'LineWidth', 1, 'HandleVisibility','off'); % 实线表示有两个零点的第一个值
end
if ~isempty(second_zeros2)
    plot(result2(:,1), result2(:,2), 'b--', 'LineWidth', 1, 'HandleVisibility','off'); % 虚线表示只有一个零点的值与有两个零点的第二个值
end


plot([second_zeros1(1,1), 12], [0, 0], 'r-', 'LineWidth', 2.5);

plot([3, second_zeros1(1,1)], [0, 0], 'r--', 'LineWidth', 2.5);

plot([second_zeros2(1,1), 12], [0, 0], 'b-', 'LineWidth', 1.5);

plot([3, second_zeros2(1,1)], [0, 0], 'b--', 'LineWidth', 1.5);


plot([3, 12], [1, 1], 'r-', 'LineWidth', 2.5, 'HandleVisibility','off');


plot([3, 12], [1, 1], 'b-', 'LineWidth', 1.5, 'HandleVisibility','off');

% legend('Stable, well-mixed population', 'Unstable, well-mixed population','Stable, structured population', 'Unstable, structured population');
hold off;

axis([3 12 0 1])
box on

xlabel('${G or k+1}$','Interpreter','latex', 'FontSize', 12);
ylabel('${x^*}$','Interpreter','latex', 'FontSize', 12);
set(gca, 'FontName', 'Arial'); 
set(gca, 'FontSize', 14);


