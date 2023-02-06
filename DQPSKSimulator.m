function [bit_error, error_theory] = DQPSKSimulator(bits, output, file, phase, coding, n, Eb, N0, x0, fs)

% This function simulates QPSK modulation

% input is the input file name
% output is the output file name
% file is the output file for storing error probabilities
% coding is one of the None, BCH(15,11), BCH(15,7)
% n is the number of bits of each sample used for simulation
% Eb is the energy per bit of the signal
% N0/2 is the power spectral density of the awgn noise

% open file for write
fileID = fopen(file, 'a');

% encoding
if isequal(coding, 'None')
    encData = bits;
elseif isequal(coding, 'BCH(15,11)')
    encData = BCH11Encoder(bits);
elseif isequal(coding, 'BCH(15,7)')
    encData = BCH7Encoder(bits);
end

% QPSK modulation
dqpsk_mod = DQPSKMod(encData, Eb);

% passing through the channel
%if isequal(coding, 'BCH(15,11)')
%    N0 = N0 * 15 / 11;
%elseif isequal(coding, 'BCH(15,7)')
%    N0 = N0 * 15 / 7;
%end
channel_out = Channel(dqpsk_mod, N0, phase);

% QPSK demodulation
if mod(length(encData), 2) == 0
    dqpsk_demod = DQPSKDemod(channel_out, 0);
else
    dqpsk_demod = DQPSKDemod(channel_out, 1);
end

% decoding
if isequal(coding, 'None')
    decData = dqpsk_demod;
elseif isequal(coding, 'BCH(15,11)')
    decData = BCH11Decoder(dqpsk_demod);
elseif isequal(coding, 'BCH(15,7)')
    decData = BCH7Decoder(dqpsk_demod);
end
decData = decData(1:length(bits)); % remove redundant bits

% finding BER and print it
bit_error = biterr(bits=='1', decData=='1')/length(bits) * 100;
error_theory = 0.5*exp(-Eb/N0);
if isequal(coding, 'BCH(15,11)')
    error_theory = nchoosek(15, 2)*error_theory^2*(1-error_theory)^13*2/15;
elseif isequal(coding, 'BCH(15,7)')
    error_theory = nchoosek(15, 3)*error_theory^3*(1-error_theory)^12*3/15;
end
error_theory = error_theory*100;
fprintf(fileID, 'Bit Error Rate for %s with Theory is %0.6f%%\n', coding, error_theory);
fprintf(fileID, 'Bit Error Rate for %s with Practice is %0.6f%%\n', coding, bit_error);
fprintf(fileID, '--------------\n');
fclose(fileID);

% convert bits to decimal form
dec_output = Bits2Dec(decData, n);
audiowrite(output, [reshape(x0, 1, length(x0)), dec_output], fs);

end
