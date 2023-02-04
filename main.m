%% QPSK Simulation

clc; clear; close all;

% parameters
input = 'input.wav'; % input file
output = 'output.wav'; % output file
n = 7; % number of MSBs we want
coding = 'None'; % coding type
EbN0 = [0, 5, 10, 15]; % Eb/N0 values in dB
Eb = 1; % energy per bit
phase = 1; % effect of phase deviation

% simulation
for ebn0=EbN0
    N0 = Eb / 10^(ebn0/10);
    QPSKSimulator(input, output, phase, coding, n, Eb, N0);
end
