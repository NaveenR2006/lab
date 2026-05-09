clc;
clear;
close all;

% Cell Radius
R = 1;

% Reuse Factor
N = 7;

% Hexagon coordinates
theta = linspace(0, 2*pi, 7);
x_hex = R * cos(theta);
y_hex = R * sin(theta);

% Frequency groups for N = 7
freq_groups = {'A','B','C','D','E','F','G'};

% Colours for frequency groups
colors = [1 0 0;
          0 1 0;
          0 0 1;
          1 1 0;
          0 1 1;
          1 0 1;
          0.5 0.5 0.5];

% Cell center positions
centers = [];

figure;
hold on;
grid on;

title('Hexagonal Cellular Layout with Frequency Reuse N = 7');
xlabel('X-axis');
ylabel('Y-axis');

count = 1;

% Generate cluster
for row = 0:3
    for col = 0:3
        
        % Hexagonal offsets
        x_off = col * 1.5 * R;
        y_off = row * sqrt(3) * R + mod(col,2)*(sqrt(3)/2 * R);

        % Store centers
        centers = [centers; x_off y_off];

        % Frequency group index
        idx = mod(count-1,7) + 1;

        % Draw hexagon
        fill(x_hex + x_off, y_hex + y_off, colors(idx,:), ...
            'EdgeColor','k');

        % Cell label
        text(x_off, y_off, freq_groups{idx}, ...
            'HorizontalAlignment','center', ...
            'FontWeight','bold');

        count = count + 1;
    end
end

%% Highlight Co-channel Cells

% Example: Highlight cells using same frequency group 'A'
A_cells = [];

count = 1;
for row = 0:3
    for col = 0:3
        
        idx = mod(count-1,7) + 1;

        x_off = col * 1.5 * R;
        y_off = row * sqrt(3) * R + mod(col,2)*(sqrt(3)/2 * R);

        if idx == 1
            plot(x_off, y_off, 'ko', ...
                'MarkerSize', 12, ...
                'LineWidth', 3);

            A_cells = [A_cells; x_off y_off];
        end

        count = count + 1;
    end
end

%% Reuse Distance Calculation

if size(A_cells,1) >= 2

    x1 = A_cells(1,1);
    y1 = A_cells(1,2);

    x2 = A_cells(2,1);
    y2 = A_cells(2,2);

    % Reuse distance
    D = sqrt((x2-x1)^2 + (y2-y1)^2);

    % Draw line between co-channel cells
    plot([x1 x2],[y1 y2],'k--','LineWidth',2);

    % Display reuse distance
    midx = (x1+x2)/2;
    midy = (y1+y2)/2;

    text(midx, midy, ['D = ' num2str(D)], ...
        'FontWeight','bold', ...
        'BackgroundColor','w');
end

axis equal;
hold off;

%% Theoretical Reuse Distance

D_theory = sqrt(3*N) * R;

fprintf('Cluster Size N = %d\n', N);
fprintf('Theoretical Reuse Distance = %.2f\n', D_theory);