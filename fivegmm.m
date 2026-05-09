clc;
clear;
close all;

%% ---------------- PARAMETERS ----------------

c = 3e8;                          % Speed of light
d = 10:10:500;                    % Distance range (m)

f1 = 28e9;                        % 28 GHz
f2 = 60e9;                        % 60 GHz

Pt = 0;                           % Transmit power (dBm)

%% ---------------- PATH LOSS MODEL ----------------

% Free Space Path Loss (FSPL)

PL_28 = 20*log10(4*pi*d*f1/c);
PL_60 = 20*log10(4*pi*d*f2/c);

% Received Signal Strength
RSS_28 = Pt - PL_28;
RSS_60 = Pt - PL_60;

%% ---------------- MULTIPATH FADING ----------------

% LOS Channel -> Rician Fading
K = 10;

rician_fading = sqrt(K/(K+1)) + ...
    sqrt(1/(K+1)) * ...
    (randn(size(d)) + 1i*randn(size(d)))/sqrt(2);

rician_dB = 20*log10(abs(rician_fading));

% NLOS Channel -> Rayleigh Fading
rayleigh_fading = ...
    (randn(size(d)) + 1i*randn(size(d)))/sqrt(2);

rayleigh_dB = 20*log10(abs(rayleigh_fading));

% Received signals with fading
RSS_LOS = RSS_28 + rician_dB;
RSS_NLOS = RSS_28 + rayleigh_dB;

%% ---------------- DISPLAY RESULTS ----------------

fprintf('Path Loss at 28 GHz for 100m = %.2f dB\n', ...
    20*log10(4*pi*100*f1/c));

fprintf('Path Loss at 60 GHz for 100m = %.2f dB\n', ...
    20*log10(4*pi*100*f2/c));

%% ---------------- PLOTTING ----------------

figure;

% Path Loss Comparison
subplot(2,1,1);

plot(d, PL_28, 'b', 'LineWidth', 2);
hold on;

plot(d, PL_60, 'r--', 'LineWidth', 2);

title('mmWave Path Loss vs Distance');
xlabel('Distance (m)');
ylabel('Path Loss (dB)');

legend('28 GHz','60 GHz');

grid on;

% LOS vs NLOS Comparison
subplot(2,1,2);

plot(d, RSS_LOS, 'g', 'LineWidth', 2);
hold on;

plot(d, RSS_NLOS, 'm--', 'LineWidth', 2);

title('Received Signal Strength');
xlabel('Distance (m)');
ylabel('RSS (dBm)');

legend('LOS (Rician)','NLOS (Rayleigh)');

grid on;