function [y] = DQPSKMod(x, Eb)

% This function get a series of bits and modulate it using DQPSK

A = sqrt(Eb); % domain of the signal
N = length(x); % length of the input
% make lentgh of the input even
if mod(N, 2) == 1
    x = append(x, '0');
    N = N + 1;
end
y = zeros(1, N/2+1); % output array
y(1) = A * (1 + 1j); % add first array of output

for i=1:N/2
    if isequal(x(2*i-1:2*i), '00')
        y(i+1) = y(i);
    elseif isequal(x(2*i-1:2*i), '01')
        y(i+1) = y(i) * exp(1j*pi/2);
    elseif isequal(x(2*i-1:2*i), '11')
        y(i+1) = y(i) * exp(1j*pi);
    else
        y(i+1) = y(i) * exp(1j*3*pi/2);
    end
end

end

