function [y0, y] = ZeroRemover(x)

% This function removes zeros from the begining of the voice

for i=1:length(x)
    % finding the index of the starting point
    if abs(x(i)) >= 0.1*abs(max(x)) 
        y0 = x(1:i-1); % zeros of the begining
        y = x(i:end); % voice
        break
    end
end

end

