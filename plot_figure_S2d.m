clear all
% 参数设置
delta = 0.4;
n_C = 0:1:9;

% 公式计算函数
calculate_value = @(p, delta, n_C) ...
    p .* abs(((1 + delta).^(n_C) - 1) ./ delta - n_C) - (1 - p) .* abs(((1 - delta).^(n_C) - 1) ./ delta - n_C);

% 计算 p = 0.3 和 p = 0.6 对应的值
p1 = 0.3;
p2 = 0.6;
y1 = calculate_value(p1, delta, n_C);
y2 = calculate_value(p2, delta, n_C);

% 绘图
figure;
plot(n_C, y1, 'b', 'LineWidth', 2);
hold on;
plot(n_C, y2, 'r', 'LineWidth', 2);
xlabel('n_C');
ylabel('AoS');

legend(['p = ', num2str(p1)], ['p = ', num2str(p2)]);
grid on;
hold off;