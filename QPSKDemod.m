function [y] = QPSKDemod(x)

% This function demodulates an input signal x(t)

N = length(x); % length of the input
y = repmat('0', [1, 2*N]);

for i=1:N
    if real(x(i)) > 0 && imag(x(i)) > 0
        y(2*i-1:2*i) = '00';
    elseif real(x(i)) < 0 && imag(x(i)) > 0
        y(2*i-1:2*i) = '01';
    elseif real(x(i)) < 0 && imag(x(i)) < 0
        y(2*i-1:2*i) = '11';
    else
        y(2*i-1:2*i) = '10';
    end
end
