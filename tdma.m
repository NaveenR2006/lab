clc;
clear;
close all;

% Number of users
num_users = 4;

% Time samples
t = 0:0.01:1;

%% ---------------- FDMA ----------------
fdma_signal = zeros(num_users, length(t));

for user = 1:num_users
    
    % Different carrier frequency for each user
    freq = user * 5;
    
    fdma_signal(user,:) = sin(2*pi*freq*t);
end

%% ---------------- TDMA ----------------
tdma_signal = zeros(num_users, length(t));

slot_length = floor(length(t)/num_users);

for user = 1:num_users
    
    start_idx = (user-1)*slot_length + 1;
    
    if user == num_users
        end_idx = length(t);
    else
        end_idx = user*slot_length;
    end
    
    tdma_signal(user,start_idx:end_idx) = 1;
end

%% ---------------- CDMA ----------------

% Walsh Codes
codes = [ 1  1  1  1;
          1 -1  1 -1;
          1  1 -1 -1;
          1 -1 -1  1 ];

cdma_signal = zeros(num_users, length(t));

for user = 1:num_users
    
    % User data signal
    data = sin(2*pi*5*t);
    
    % Repeat spreading code
    code = repmat(codes(user,:), 1, ceil(length(t)/4));
    
    code = code(1:length(t));
    
    % Spread spectrum signal
    cdma_signal(user,:) = data .* code;
end

%% ---------------- Plotting ----------------

figure;

% FDMA Plot
subplot(3,1,1);

plot(t, fdma_signal);

title('FDMA - Frequency Division Multiple Access');
xlabel('Time');
ylabel('Amplitude');

legend('User 1','User 2','User 3','User 4');

grid on;

% TDMA Plot
subplot(3,1,2);

plot(t, tdma_signal);

title('TDMA - Time Division Multiple Access');
xlabel('Time');
ylabel('Amplitude');

legend('User 1','User 2','User 3','User 4');

grid on;

% CDMA Plot
subplot(3,1,3);

plot(t, cdma_signal);

title('CDMA - Code Division Multiple Access');
xlabel('Time');
ylabel('Amplitude');

legend('User 1','User 2','User 3','User 4');

grid on;