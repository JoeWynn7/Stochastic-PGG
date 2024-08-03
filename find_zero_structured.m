clear all

% Define Parameters
r = 4; % r
k = 4; % k
p = 0.3; % p
delta = 0.9; % delta

% Define equation
fun = @(x) abs(phi1(x, p, delta, r, k) - phi2(x, p, delta, r, k) - phi3(x, p, delta, r, k) + phi4(x, p, delta, r, k) - (k - 2) * x * (phi2(x, p, delta, r, k) - phi4(x, p, delta, r, k)));

% Solve an equation
x_solution = fminbnd(fun, 0.01, 0.99);

disp(['The maxium x^* between [0.01 0.99] is: : ', num2str(x_solution)]);

% 定义phi1函数
function result = phi1(x, p, delta, r, k)
    lam1 = p * (1 + delta) * (1 + (((k - 2) * x + 1) / (k - 1)) * delta)^(k - 1);
    lam2 = p * (1 + (((k - 2) * x) / (k - 1)) * delta)^(k - 1);
    lam3 = (1 - p) * (1 - delta) * (1 - (((k - 2) * x + 1) / (k - 1)) * delta)^(k - 1);
    lam4 = (1 - p) * (1 - (((k - 2) * x) / (k - 1)) * delta)^(k - 1);
    result = (r / ((k + 1) * delta)) * (((k-2)*x+1)*((1 + delta) * (lam1 - lam2) - (1 - delta) * (lam3 - lam4)) + (lam1 - lam2 - lam3 + lam4) + delta * (k - 1) * (lam2 + lam4)) - (k + 1);
end

% 定义phi2函数
function result = phi2(x, p, delta, r, k)
    lam1 = p * (1 + delta) * (1 + (((k - 2) * x + 1) / (k - 1)) * delta)^(k - 1);
    lam2 = p * (1 + (((k - 2) * x) / (k - 1)) * delta)^(k - 1);
    lam3 = (1 - p) * (1 - delta) * (1 - (((k - 2) * x + 1) / (k - 1)) * delta)^(k - 1);
    lam4 = (1 - p) * (1 - (((k - 2) * x) / (k - 1)) * delta)^(k - 1);
    result = (r / ((k + 1) * delta)) * (lam1 - lam2 - lam3 + lam4);
end

% 定义phi3函数
function result = phi3(x, p, delta, r, k)
    lam1 = p * (1 + delta) * (1 + (((k - 2) * x + 1) / (k - 1)) * delta)^(k - 1);
    lam2 = p * (1 + (((k - 2) * x) / (k - 1)) * delta)^(k - 1);
    lam3 = (1 - p) * (1 - delta) * (1 - (((k - 2) * x + 1) / (k - 1)) * delta)^(k - 1);
    lam4 = (1 - p) * (1 - (((k - 2) * x) / (k - 1)) * delta)^(k - 1);
    result = (r / ((k + 1) * delta)) * ((k - 2) * x * (lam1 - lam2 - lam3 + lam4) - delta * (k - 1) * (lam2 + lam4)) + k + 1;
end

% 定义phi4函数
function result = phi4(x, p, delta, r, k)
    lam1 = p * (1 + delta) * (1 + (((k - 2) * x + 1) / (k - 1)) * delta)^(k - 1);
    lam2 = p * (1 + (((k - 2) * x) / (k - 1)) * delta)^(k - 1);
    lam3 = (1 - p) * (1 - delta) * (1 - (((k - 2) * x + 1) / (k - 1)) * delta)^(k - 1);
    lam4 = (1 - p) * (1 - (((k - 2) * x) / (k - 1)) * delta)^(k - 1);
    result = (r / ((k + 1) * delta)) * ((1 + delta) * (lam1 - lam2) - (1 - delta) * (lam3 - lam4));
end
