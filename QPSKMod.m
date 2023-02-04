function [y] = QPSKMod(x, Eb)

% This function get a series of bits and modulate it using QPSK

A = sqrt(2*Eb); % domain of the signal
N = length(x); % length of the input
% make lentgh of the input even
if mod(N, 2) == 1
    x = append(x, '0');
    N = N + 1;
end
y = zeros(1, N/2); % output array

for i=1:N/2
    if isequal(x(2*i-1:2*i), '00')
        y(i) = A * (1 + 1j);
    elseif isequal(x(2*i-1:2*i), '01')
        y(i) = A * (-1 + 1j);
    elseif isequal(x(2*i-1:2*i), '11')
        y(i) = A * (-1 - 1j);
    else
        y(i) = A * (1 - 1j);
    end
end

end

