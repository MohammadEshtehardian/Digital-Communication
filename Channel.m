function [y] = Channel(x, N0)

% This function gets a signal and add it with noise

y = x + sqrt(N0/2) * (randn(size(x)) + 1j * randn(size(x)));

end

