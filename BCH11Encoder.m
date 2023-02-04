function [y] = BCH11Encoder(x)

% This function implements bch(15, 11) encoder

data = x=='1'; % convert string to array
n = 15; % length of code
k = 11; % length of data
genpoly = [1, 0, 0, 1, 1]; % generator polynomial

% encode data
encData = encode(data,n,k,'cyclic/binary',genpoly);
y = num2str(encData);
y = y(~isspace(y));

end

