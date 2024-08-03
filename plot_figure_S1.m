clear all;

% Define parameter range
G = 5;
delta1_values = linspace(0, 1, 200);
delta2_values = linspace(0, 1, 200);
r_values = [2, 4, 6, 8];
p_values = [0.1, 0.3, 0.6, 0.9];

% Prepare colormap
myColormap = [
    130 176 210; %  C
    250, 127, 111; %  D
    126 197 189; % C+D
    251 222 159; % bi C+D
    170 210 224; % - bi-C+D C
]/255;

% Loop over each value of r and p
for r = r_values
    for p = p_values
        % Initialize matrices to store the states and fractions
        states = zeros(length(delta1_values), length(delta2_values));
        fracs1 = zeros(length(delta1_values), length(delta2_values));
        fracs2 = NaN(length(delta1_values), length(delta2_values));

        % Compute states for each pair of delta1 and delta2
        for i = 1:length(delta2_values)
            for j = 1:length(delta1_values)
                [states(i, j), fracs1(i, j), fracs2(i, j)] = analyze_state(r, G, p, delta1_values(j),delta2_values(i));
            end
        end

        % Plotting
        fig = figure;
        fig.Position = [147, 766, 224, 177];
        states(states == -1) = NaN;
        imagesc(delta1_values, delta2_values, states);
        colormap(myColormap);
        caxis([0 4]);
        axis xy;

        % Contour lines to distinguish states
        hold on;
        contour_levels = [0.5, 1.5, 2.5, 3.5];
        contour(delta1_values, delta2_values, states, contour_levels, 'LineColor', 'w', 'LineWidth', 1, 'ShowText', 'off');
        hold on; 
        plot(delta1_values, delta2_values, 'w--', 'LineWidth', 0.5); 
        hold off;

        % Label and aesthetics
        xlabel('${\delta_1}$','Interpreter','latex', 'FontSize', 12);
        ylabel('${\delta_2}$','Interpreter','latex', 'FontSize', 12);
        set(gca, 'FontName', 'Arial', 'FontSize', 14);
        box on;
        % Save each figure with a specific filename
        filename = sprintf('states_r_%d_p_%.1f.fig', r, p);
        savefig(fig, filename); % Save as .fig
    end
end



function [state, frac1, frac2] = analyze_state(r, G, p, delta1, delta2)
    f = @(x, r, G, p, delta1, delta2) x * (1 - x) * tanh(((r / G) * (p * (1 + delta1 * x) ^ (G - 1) + (1 - p) * (1 - delta2 * x) ^ (G - 1)) - 1)*0.005);
    x_values = linspace(0, 1, 2000);
    dx_values = arrayfun(@(x) f(x, r, G, p, delta1, delta2), x_values);
    zeros = [];

    for i = 3:length(dx_values)-1
        if dx_values(i - 1) * dx_values(i) <= 0
            zeros = [zeros, i];
        end
    end

    frac2 = NaN; 

    if isempty(zeros)
        if dx_values(2) > 0 && dx_values(end-1) > 0
            state = 0;
            frac1 = 1;
        elseif dx_values(2) < 0 && dx_values(end-1) < 0
            state = 1;
            frac1 = 0;
        else
            state = NaN;
            frac1 = NaN;
        end
    elseif length(zeros) == 1
        if dx_values(zeros(1) - 1) > 0 && dx_values(zeros(1) + 1) < 0
            state = 2;
        elseif dx_values(zeros(1) - 1) < 0 && dx_values(zeros(1) + 1) > 0
            state = 3;
        else
            state = NaN;
        end
        frac1 = x_values(zeros(1));
    elseif length(zeros) == 2
        state = 4;
        frac1 = x_values(zeros(2));
        frac2 = x_values(zeros(1));
    else
        state = NaN;
        frac1 = NaN;
    end
end