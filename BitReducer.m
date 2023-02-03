function [y, y_bin] = BitReducer(x, n)

% This function compress a sound samples to n bits

x1 = x*2^16; % converts sound samples to integers
y = zeros(1, length(x)); % output sound
y_bin = repmat('0', [1, n*length(x)]); % binary output

for i=1:length(x1)
    b = dec2bin(x1(i), 16); % get binary form
    % remove LSBs and back to decimal
    y_bin((i-1)*n+1:i*n) = b(1:n);
    y(i) = bin2dec(b(1:n)); 
    if y(i) > 2^(n-1)-1
        y(i) = y(i) - 2^n;
    end
end

y = y / 2^n;

end

