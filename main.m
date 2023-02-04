clc; clear; close all;
[x, fs] = audioread('input.wav');
x = x(:, 1);
[x0, x] = ZeroRemover(x);
[a, y_bin] = BitReducer(x, 7);
encData = BCH11Encoder(y_bin);
z = QPSKMod(encData, 1);
z = Channel(z, 1);
y = QPSKDemod(z);
decData = BCH11Decoder(y);
biterr(y_bin=='1', decData(1:length(y_bin))=='1')/length(y_bin)
%w = Bits2Dec(decData, 7);
%audiowrite('output.wav', w, fs);
