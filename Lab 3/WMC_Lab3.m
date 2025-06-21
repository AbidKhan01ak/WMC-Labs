clc;
clear all;
close all;

%% Constants
fc = 100;          % Carrier frequency in Hz
fm = 10;           % Message frequency in Hz
Fs = 10000;        % Sampling frequency
t = 0:1/Fs:0.1;    % Time vector
Ac = 1;            % Carrier amplitude (assumed)

Ka = 0.4;          % Amplitude sensitivity factor
Am_values = [1, 2, 3];  % Message amplitudes

%% 1. Plot envelope traces for Ka = 0.4 and Am = 1, 2, 3
figure('Name','Envelope of AM Signal for given Ka and Am');
for i = 1:length(Am_values)
    Am = Am_values(i);
    m_t = Am * cos(2*pi*fm*t);                     % Message signal
    s_t = Ac * (1 + Ka * Am * cos(2*pi*fm*t)) .* cos(2*pi*fc*t);  % AM signal

    subplot(3,1,i);
    plot(t, s_t);
    title(['Envelope of AM Signal: K_a = 0.4, A_m = ', num2str(Am)]);
    xlabel('Time (s)');
    ylabel('Amplitude');
    grid on;
end

%% 2. AM Modulation and Demodulation (Using A_m = 2 for demonstration)
Am = 2;
m_t = Am * cos(2*pi*fm*t);                         % Message signal
carrier = Ac * cos(2*pi*fc*t);                     % Carrier signal
am_modulated = Ac * (1 + Ka * Am * cos(2*pi*fm*t)) .* cos(2*pi*fc*t);

% Demodulation using envelope detection
demodulated = abs(am_modulated);                  % Ideal rectifier
[b, a] = butter(6, 2*fm/(Fs/2));                   % Low-pass filter
demodulated_filtered = filter(b, a, demodulated);

figure('Name','AM Modulation and Demodulation');
subplot(3,1,1);
plot(t, m_t);
title('Message Signal');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

subplot(3,1,2);
plot(t, am_modulated);
title('AM Modulated Signal (K_a = 0.4, A_m = 2)');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

subplot(3,1,3);
plot(t, demodulated_filtered);
title('Demodulated Signal after Envelope Detection');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

%% 3. DSB-SC Signal
dsb_sc = m_t .* carrier;

figure('Name','DSB-SC Signal');
plot(t, dsb_sc);
title('DSB-SC Signal (Double Side Band - Suppressed Carrier)');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

%% 4. SSB Signal using Hilbert Transform
m_hilbert = hilbert(m_t);                          % Analytic signal
ssb_usb = real(m_hilbert .* exp(1j*2*pi*fc*t));    % Upper Sideband SSB

figure('Name','SSB-SC (Upper Sideband) Signal');
plot(t, ssb_usb);
title('SSB-SC (Upper Sideband) Signal');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;
