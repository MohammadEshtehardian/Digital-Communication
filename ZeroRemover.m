function [y0, y] = ZeroRemover(x)

% This function removes zeros from the begining of the voice

for i=1:length(x)
    % finding the index of the starting point
    t = max([max(x), -min(x)]);
    if abs(x(i)) >= 0.1*t
        y0 = x(1:i-1); % zeros of the begining
        y = x(i:end); % voice
        break
    end
end

end

