function [y] = Channel(x, N0, phase)

% This function gets a signal and add it with noise

y = x + sqrt(N0/2) * (randn(size(x)) + 1j * randn(size(x)));

if phase == 1
    k = randi([0, 7]);
    y = y * exp(1j*k*pi/4);

end

