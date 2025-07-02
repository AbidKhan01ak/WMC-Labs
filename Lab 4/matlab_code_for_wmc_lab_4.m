% WMC LAB 4 - Digital Modulation Techniques.

% Name - Abid Rafique Khan
% BITS ID - 2021WA86438

% To plot the signal for ASK, FSK, and PSK for binary input 101101
clc; clear; close all;

% Binary data
data = [1 0 1 1 0 1];
bit_duration = 1;         % Bit time in seconds
fs = 1000;                % Sampling frequency
fc1 = 10;                 % Carrier frequency for ASK and PSK
f1 = 10; f2 = 20;         % Frequencies for FSK
t = 0:1/fs:bit_duration-1/fs;  % Time vector for one bit
total_time = [];

% Signals
ask_mod = [];
fsk_mod = [];
psk_mod = [];

% Modulation process
for i = 1:length(data)
    bit = data(i);

    % ASK
    if bit == 1
        ask = cos(2*pi*fc1*t);
    else
        ask = zeros(1, length(t));
    end
    ask_mod = [ask_mod ask];

    % FSK
    if bit == 1
        fsk = cos(2*pi*f1*t);
    else
        fsk = cos(2*pi*f2*t);
    end
    fsk_mod = [fsk_mod fsk];

    % PSK (BPSK)
    if bit == 1
        psk = cos(2*pi*fc1*t);
    else
        psk = cos(2*pi*fc1*t + pi);  % Phase shift of 180°
    end
    psk_mod = [psk_mod psk];
end

% Total time axis
total_time = 0:1/fs:(length(data)*bit_duration)-1/fs;

% Plot ASK
figure;
plot(total_time, ask_mod, 'b', 'LineWidth', 1.5);
title('ASK Modulated Signal');
xlabel('Time (s)'); ylabel('Amplitude');
grid on;

% Plot FSK
figure;
plot(total_time, fsk_mod, 'r', 'LineWidth', 1.5);
title('FSK Modulated Signal');
xlabel('Time (s)'); ylabel('Amplitude');
grid on;

% Plot PSK
figure;
plot(total_time, psk_mod, 'g', 'LineWidth', 1.5);
title('PSK Modulated Signal');
xlabel('Time (s)'); ylabel('Amplitude');
grid on;
