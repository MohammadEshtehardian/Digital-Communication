%% QPSK Simulation

clc; clear; close all;

% parameters
input = 'input.wav'; % input file
n = 7; % number of MSBs we want
coding = 'BCH(15,7)'; % coding type
SNR = [0, 5, 15, 20]; % Eb/N0 values in dB
Eb = 1; % energy per bit
phase = 0; % effect of phase deviation
file = sprintf('error-probability/qpsk/%s.txt', coding); % file for error probabilities
if isfile(file)
    delete(file);
end
[x, fs] = audioread(input); % reading input
x = x(:, 1); % using only one channel
[x0, x] = ZeroRemover(x); % remove zeros from the begining
[~, bits] = BitReducer(x, n); % removing LSBs
theoretical_error = zeros(1, length(SNR));
practical_error = zeros(1, length(SNR));

% simulation
for i=1:length(SNR)
    snr = SNR(i);
    N0 = Eb / 10^(snr/10);
    output = sprintf('sounds/qpsk/%s-%d.wav', coding, snr);
    [bit_error, error_theory] = QPSKSimulator(bits, output, file, phase, coding, n, Eb, N0, x0, fs);
    theoretical_error(i) = error_theory;
    practical_error(i) = bit_error;
end

%%
figure;
semilogy(SNR, theoretical_error); hold on;
semilogy(SNR, practical_error); hold off;
title('Probability of Error with $BCH(15, 11)$', 'interpreter', 'latex');
xlabel('BER', 'interpreter', 'latex');
ylabel('Error Probability', 'interpreter', 'latex');
legend('Theoretical', 'Practical', 'interpreter', 'latex');
grid on;


