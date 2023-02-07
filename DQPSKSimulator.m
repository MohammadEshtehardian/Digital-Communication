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
if isequal(coding, 'BCH(15,11)')
    N0 = N0 * 15 / 11;
elseif isequal(coding, 'BCH(15,7)')
    N0 = N0 * 15 / 7;
end
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
bit_error = biterr(bits=='1', decData=='1')/length(bits);
error_theory = (1 - (1 - qfunc(sqrt(Eb/N0)))^2)/2;
if isequal(coding, 'BCH(15,11)')
    p = error_theory;
    error_theory = 0;
    for i=2:15
        error_theory = error_theory + nchoosek(15, i)*p^i*(1-p)^(15-i)*i/15;
    end
elseif isequal(coding, 'BCH(15,7)')
    p = error_theory;
    error_theory = 0;
    for i=3:15
        error_theory = error_theory + nchoosek(15, i)*p^i*(1-p)^(15-i)*i/15;
    end
end
fprintf(fileID, 'Value of SNR/bit is %0.3f dB\n', 10*log10(Eb/N0));
fprintf(fileID, 'Bit Error Probability for %s with Theory is %d\n', coding, error_theory);
fprintf(fileID, 'Bit Error Probability for %s with Practice is %d\n', coding, bit_error);
fprintf(fileID, '--------------\n');
fclose(fileID);

% convert bits to decimal form
dec_output = Bits2Dec(decData, n);
audiowrite(output, [reshape(x0, 1, length(x0)), dec_output], fs);

end
