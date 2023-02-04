function [bit_error] = QPSKSimulator(input, output, phase, coding, n, Eb, N0)

% This function simulates QPSK modulation

% input is the input file name
% output is the output file name
% coding is one of the None, BCH(15,11), BCH(15,7)
% n is the number of bits of each sample used for simulation
% Eb is the energy per bit of the signal
% N0/2 is the power spectral density of the awgn noise

% reading input
[x, fs] = audioread(input);
x = x(:, 1); % using only one channel
[x0, x] = ZeroRemover(x); % remove zeros from the begining
[~, bits] = BitReducer(x, n); % removing LSBs

% encoding
if isequal(coding, 'None')
    encData = bits;
elseif isequal(coding, 'BCH(15,11)')
    encData = BCH11Encoder(bits);
elseif isequal(coding, 'BCH(15,7)')
    encData = BCH7Encoder(bits);
end

% QPSK modulation
qpsk_mod = QPSKMod(encData, Eb);

% passing through the channel
channel_out = Channel(qpsk_mod, N0, phase);

% QPSK demodulation
if mod(length(encData), 2) == 0
    qpsk_demod = QPSKDemod(channel_out, 0);
else
    qpsk_demod = QPSKDemod(channel_out, 1);
end

% decoding
if isequal(coding, 'None')
    decData = qpsk_demod;
elseif isequal(coding, 'BCH(15,11)')
    decData = BCH11Decoder(qpsk_demod);
elseif isequal(coding, 'BCH(15,7)')
    decData = BCH7Decoder(qpsk_demod);
end
decData = decData(1:length(bits)); % remove redundant bits

% finding BER and print it
bit_error = biterr(bits=='1', decData=='1')/length(bits) * 100;
fprintf('Bit Error Rate for %s is %0.4f%%\n', coding, bit_error);

% convert bits to decimal form
dec_output = Bits2Dec(decData, n);
audiowrite(output, [reshape(x0, 1, length(x0)), dec_output], fs);


end
