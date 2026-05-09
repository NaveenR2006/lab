clc;
clear;
close all;

% Parameters
f = 900;                    % Frequency in MHz
d = 1:1:20;                 % Distance from 1 km to 20 km
hb_values = [30 50 70 100]; % Base station antenna heights
hm_values = [1 3 5 10];     % Mobile station antenna heights

env = 'urban';

% Urban correction factor for small/medium city
figure;
hold on;
grid on;

title('Okumura and Hata Model - Urban Environment');
xlabel('Distance (km)');
ylabel('Path Loss (dB)');

for hb = hb_values
    
    hm = 1.5; % Fixed mobile antenna height
    
    hata_loss = zeros(size(d));
    okumura_loss = zeros(size(d));
    
    for i = 1:length(d)
        
        % Mobile antenna correction factor
        a_hm = (1.1*log10(f)-0.7)*hm - (1.56*log10(f)-0.8);
        
        % Hata Model
        hata_loss(i) = 69.55 + 26.16*log10(f) ...
                     - 13.82*log10(hb) ...
                     - a_hm ...
                     + (44.9 - 6.55*log10(hb))*log10(d(i));
                 
        % Okumura Model
        Lf = 32.45 + 20*log10(f) + 20*log10(d(i));
        
        Amu = 30; % Urban area correction
        
        okumura_loss(i) = Lf ...
                        - 20*log10(hb/200) ...
                        - 10*log10(hm/3) ...
                        - Amu;
    end
    
    % Plot Hata
    plot(d, hata_loss, 'LineWidth', 2);
    
    % Plot Okumura
    plot(d, okumura_loss, '--', 'LineWidth', 2);
    
end

legend('Hata hb=30m','Okumura hb=30m', ...
       'Hata hb=50m','Okumura hb=50m', ...
       'Hata hb=70m','Okumura hb=70m', ...
       'Hata hb=100m','Okumura hb=100m');

%% Effect of Mobile Station Height

figure;
hold on;
grid on;

title('Effect of Mobile Antenna Height');
xlabel('Distance (km)');
ylabel('Path Loss (dB)');

hb = 50; % Fixed base station height

for hm = hm_values
    
    hata_loss = zeros(size(d));
    
    for i = 1:length(d)
        
        a_hm = (1.1*log10(f)-0.7)*hm - (1.56*log10(f)-0.8);
        
        hata_loss(i) = 69.55 + 26.16*log10(f) ...
                     - 13.82*log10(hb) ...
                     - a_hm ...
                     + (44.9 - 6.55*log10(hb))*log10(d(i));
    end
    
    plot(d, hata_loss, 'LineWidth', 2);
end

legend('hm=1m','hm=3m','hm=5m','hm=10m');