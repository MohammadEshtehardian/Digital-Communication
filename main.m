%% QPSK Simulation

clc; clear; close all;

% parameters
input = 'input.wav'; % input file
n = 7; % number of MSBs we want
coding = 'None'; % coding type
SNR = [0, 5, 10, 15]; % Eb/N0 values in dB
Eb = 1; % energy per bit
phase = 0; % effect of phase deviation

% simulation
for snr=SNR
    N0 = Eb / 10^(snr/10);
    output = sprintf('sounds/qpsk/%s-%d.wav', coding, snr);
    file = sprintf('error-probability/qpsk/%s.txt', coding);
    QPSKSimulator(input, output, file, phase, coding, n, Eb, N0);
end
