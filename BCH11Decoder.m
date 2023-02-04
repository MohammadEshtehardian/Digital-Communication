function [y] = BCH11Decoder(x)

% This function implements BCH(15,11) decoder

data = x=='1'; % convert string to array
n = 15; % length of code
k = 11; % length of data
genpoly = [1, 0, 0, 1, 1]; % generator polynomial
parmat = cyclgen(n,genpoly); % generate parity-check matrix
trt = syndtable(parmat); % create syndrome table

% decode data
decData = decode(data,n,k,'cyclic/binary',genpoly,trt);
y = num2str(decData);
y = y(~isspace(y));

end

