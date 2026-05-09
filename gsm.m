clc;
clear;
close all;

% GSM Call Setup States
states = {'Idle', ...
    'Channel Request', ...
    'Authentication', ...
    'Channel Assignment', ...
    'Call Setup', ...
    'Call Active', ...
    'Call Release'};

% Initial State
current_state = 'Idle';

disp('--- GSM CALL SETUP PROCEDURE ---');

% Display state transitions
for i = 1:length(states)

    disp(['Current State : ', current_state]);

    current_state = transition(current_state);

    pause(1);

end

disp(['Current State : ', current_state]);
disp('GSM Call Procedure Completed');

%% -------- State Transition Diagram --------

figure;

axis([0 14 0 10]);
axis off;

title('GSM Call Setup State Transition Diagram');

% Coordinates for states
x = [1 3 5 7 9 11 13];
y = [5 5 5 5 5 5 5];

% Draw states
for i = 1:length(states)

    rectangle('Position',[x(i)-0.6 y(i)-0.5 1.2 1], ...
        'Curvature',[1 1], ...
        'FaceColor',[0.8 0.9 1]);

    text(x(i), y(i), states{i}, ...
        'HorizontalAlignment','center', ...
        'FontWeight','bold');
end

% Draw arrows
for i = 1:length(states)-1

    annotation('arrow', ...
        [(x(i)+0.6)/14 (x(i+1)-0.6)/14], ...
        [0.5 0.5], ...
        'LineWidth',2);

end

%% -------- Transition Function --------

function next_state = transition(current_state)

switch current_state

    case 'Idle'
        next_state = 'Channel Request';

    case 'Channel Request'
        next_state = 'Authentication';

    case 'Authentication'
        next_state = 'Channel Assignment';

    case 'Channel Assignment'
        next_state = 'Call Setup';

    case 'Call Setup'
        next_state = 'Call Active';

    case 'Call Active'
        next_state = 'Call Release';

    otherwise
        next_state = 'Completed';
end

end