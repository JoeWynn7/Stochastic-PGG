clear all
% Define Parameters
r = 5.1; % r
G = 5; % G
p = 0.4; % p
delta = 0.15; % delta

% Define equation
fun = @(x) abs(tanh(((r / G) * (p * (1 + delta * x) ^ (G - 1) + (1 - p) * (1 - delta * x) ^ (G - 1)) - 1) * 0.4));

% Solve an equation
x_solution = fminbnd(fun, 0, 1);

disp(['The maxium x^* between [0 1] is: ', num2str(x_solution)]);