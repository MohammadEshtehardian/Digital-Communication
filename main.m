%% QPSK Simulation

clc; clear; close all;

% parameters
input = 'input.wav'; % input file
output = 'output.wav'; % output file
n = 7; % number of MSBs we want
coding = 'BCH(15,7)'; % coding type
SNR = [0, 5, 10, 15]; % Eb/N0 values in dB
Eb = 1; % energy per bit
phase = 0; % effect of phase deviation

% simulation
for snr=SNR
    N0 = Eb / 10^(snr/10);
    QPSKSimulator(input, output, phase, coding, n, Eb, N0);
end
