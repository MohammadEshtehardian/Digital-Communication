function [y] = Bits2Dec(x, n)

% This function get a series of bits and convert its samples to decimal

N = length(x); % number of bits
if mod(N, n) ~= 0
    N = N - mod(N, n);
    x = x(1:N);
end
y = zeros(1, N/n);

for i=1:N/n
    j = 1 + n*(i-1);
    y(i) = bin2dec(x(j:j+n-1));
    if y(i) > 2^(n-1)-1
        y(i) = y(i) - 2^n;
    end
end

y = y / 2^n;

end

